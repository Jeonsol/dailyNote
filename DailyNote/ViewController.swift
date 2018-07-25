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
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var selectDateLabel: UIButton!
    @IBOutlet weak var calendarWrap: UIView!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var shouldShowDaysOut = true
    private var calendarToggle = true
    private var calendarOriginPositionY : CGFloat?
    
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
    }
    
    @IBAction func moveCalendar(_ sender: UIButton) {
        if calendarToggle {
            UIView.animate(withDuration: 1) {
                self.calendarWrap.frame.origin.y = -(self.calendarWrap.frame.height)
            }
        }
        else {
            UIView.animate(withDuration: 1) {
                self.calendarWrap.frame.origin.y = self.calendarOriginPositionY!
            }
        }
        self.calendarToggle = !calendarToggle
        scrollView.isScrollEnabled = !calendarToggle
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
