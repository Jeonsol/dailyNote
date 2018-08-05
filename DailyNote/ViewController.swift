//
//  ViewController.swift
//  DailyNote
//
//  Created by 전솔 on 2018. 7. 17..
//  Copyright © 2018년 전솔. All rights reserved.
//

import UIKit
import CVCalendar

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var selectDateLabel: UIButton!
    @IBOutlet weak var calendarWrap: UIView!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var textView: UILabel!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    
    private var shouldShowDaysOut = true
    private var calendarToggle = true
    private var calendarOriginPositionY : CGFloat?
    private var contentOriginPositionY : CGFloat?
    private var selectedDate : String?
    private var selectedData : AnyObject?
    private var diaries : Dictionary<String,Any> = Global.shared.diaryStore.diaries
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.calendarView.calendarAppearanceDelegate = self
        
        self.calendarView.animatorDelegate = self
        
        self.calendarView.calendarDelegate = self
        
        self.menuView.menuViewDelegate = self
        
        shouldShowDaysOut = true
        selectDateLabel.setTitle(calendarView.presentedDate.commonDescription, for: .normal)
        calendarOriginPositionY = self.calendarWrap.frame.origin.y
        contentOriginPositionY = self.contentScrollView.frame.origin.y
        
        let contentScrollTouch = UITapGestureRecognizer(target: self, action: #selector(goWriteViewControll))
        self.contentScrollView.addGestureRecognizer(contentScrollTouch)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    @IBAction func moveCalendar(_ sender: UIButton) {

        if calendarToggle {
            contentScrollView.frame.size.height =  UIScreen.main.bounds.size.height
            UIView.animate(withDuration: 1) {
                self.calendarWrap.frame.origin.y = -(self.calendarWrap.frame.height)
                self.contentScrollView.frame.origin.y = 80
            }
        }
        else {
            UIView.animate(withDuration: 1) {
                self.calendarWrap.frame.origin.y = self.calendarOriginPositionY!
                self.contentScrollView.frame.origin.y = self.contentOriginPositionY!
            }
        }
        self.calendarToggle = !calendarToggle
        self.scrollView.isScrollEnabled = calendarToggle
        self.contentScrollView.isScrollEnabled = !calendarToggle
    }
    
    @objc private func goWriteViewControll() {
        let writeView = storyboard?.instantiateViewController(withIdentifier: "writeViewController") as? WriteViewController
        writeView?.today = selectedDate
        if let selectedDiary = selectedData {
            writeView?.modifyData = selectedDiary as AnyObject
        }
        self.show(writeView!, sender: self)
    }
    
    private func loadData() {
        imageView.isHidden = true
        if let selectedDiaries = diaries[selectedDate!] {
            selectedData = selectedDiaries as AnyObject
            if let imageData = (selectedData as AnyObject)["image"] {
                if ((imageData as? NSData) != nil) {
                    imageView.isHidden = false
                    imageView.image = UIImage(data: imageData as! Data)!
                }
            }
            if let content = (selectedData as AnyObject)["content"] {
                textView.text = content as? String
            }
            
        } else {
            selectedData = nil
            textView?.text = "작성된 글이 없습니다."
        }
    }
    
}

extension ViewController: CVCalendarMenuViewDelegate, CVCalendarViewDelegate  {
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return .sunday
    }
    
    func shouldShowWeekdaysOut() -> Bool { return shouldShowDaysOut }
    
    func didSelectDayView(_ dayView: CVCalendarDayView, animationDidFinish: Bool) {
        selectDateLabel.setTitle(dayView.date.commonDescription, for: .normal)
        selectedDate = dayView.date.commonDescription
        loadData()
    }
}

extension ViewController: CVCalendarViewAppearanceDelegate {
    func dayLabelBackgroundColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (_, .selected, _), (_, .highlighted, _):
            return UIColor.gray
        default:
            return nil
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > 0 || scrollView.contentOffset.x < 0{
            scrollView.contentOffset.x = 0
        }
    }
}
