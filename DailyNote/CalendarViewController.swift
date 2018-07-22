//
//  CalendarViewController.swift
//  DailyNote
//
//  Created by 전솔 on 2018. 7. 22..
//  Copyright © 2018년 전솔. All rights reserved.
//

import UIKit
import CVCalendar

class CalendarViewController: UIViewController, CVCalendarMenuViewDelegate, CVCalendarViewDelegate  {

    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        // Appearance delegate [Unnecessary]
        self.calendarView.calendarAppearanceDelegate = self
        
        // Animator delegate [Unnecessary]
        self.calendarView.animatorDelegate = self
        
        // Calendar delegate [Required]
        self.calendarView.calendarDelegate = self
        
        // Menu delegate [Required]
        self.menuView.menuViewDelegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
    }
    
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return .sunday
    }
}
