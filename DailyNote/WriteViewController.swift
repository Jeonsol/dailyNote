//
//  WriteViewController.swift
//  DailyNote
//
//  Created by 전솔 on 2018. 7. 30..
//  Copyright © 2018년 전솔. All rights reserved.
//

import UIKit

class WriteViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    
    var keyboardToggle: Bool = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboradWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboradWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let keyboardStatus = UITapGestureRecognizer(target: self, action: #selector(exposureKeyboard))
        self.textView.addGestureRecognizer(keyboardStatus)
        scrollView.contentInset =  UIEdgeInsetsMake(0, 0, 271.0, 0)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func exposureKeyboard() {
        if(keyboardToggle) {
            textView.becomeFirstResponder()
        } else {
            textView.resignFirstResponder()
        }
        keyboardToggle = !keyboardToggle
    }
    
    @objc func keyboradWillShow(notification: Notification) {
        guard let info = notification.userInfo else { return }
        guard let keyboardFrame = info[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        UIView.animate(withDuration: 1.0) {
            self.contentViewHeight.constant = -keyboardFrame.height
            self.view.layoutIfNeeded()
        }
//        self.scrollView.isScrollEnabled = true
//
//        guard let info = notification.userInfo else { return }
//        guard let keyboardFrame = info[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }
//
//        let inset = UIEdgeInsetsMake(0, 0, keyboardFrame.height, 0)
//
//        scrollView.contentInset = inset
//        print("show", inset)
//        scrollView.contentSize = contentView.frame.size
//        수정필요
//        1. 스크롤뷰 사이즈 줄이기
        
    }
    
    @objc func keyboradWillHide(notification: Notification) {
        UIView.animate(withDuration: 1.0) {
            self.contentViewHeight.constant = 0.0
            self.view.layoutIfNeeded()
        }
//        print("hide")
//        scrollView.contentInset = UIEdgeInsets.zero
//        scrollView.isScrollEnabled = false
//        수정필요
//        1. 스크롤뷰 사이즈 원상복구
    }
}
