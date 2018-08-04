//
//  WriteViewController.swift
//  DailyNote
//
//  Created by 전솔 on 2018. 7. 30..
//  Copyright © 2018년 전솔. All rights reserved.
//

import UIKit
import Foundation

class WriteViewController: UIViewController {

    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var thumbnail: UIButton!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    
    let now=NSDate()
    let dateFormatter = DateFormatter()
    let imagePicker = UIImagePickerController()
    var imageContainer : UIImage?
    var keyboardToggle: Bool = false
    var today : String?
    var currentTime: String?
    var diaryStore:DiaryStore = Global.shared.diaryStore
    private var textValue: String {
        get {
            return textView.text
        }
        set {
            textView.text = textView.text!+String(newValue)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboradWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboradWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        self.navigationController?.navigationBar.isHidden = true
        textView.becomeFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let keyboardStatus = UITapGestureRecognizer(target: self, action: #selector(exposureKeyboard))
        self.textView.addGestureRecognizer(keyboardStatus)
        todayLabel.text = today
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        self.navigationController?.navigationBar.isHidden = false
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
    }
    
    @objc func keyboradWillHide(notification: Notification) {
        UIView.animate(withDuration: 1.0) {
            self.contentViewHeight.constant = 0.0
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func getTime(_ sender: UIButton) {
        dateFormatter.dateFormat = "HH:mm"
        self.currentTime = dateFormatter.string(from: now as Date)
        textValue = self.currentTime!
    }
    @IBAction func getPhoto(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func addDiary(_ sender: UIButton) {
        guard let content = textView.text else {return}
        guard let image = imageContainer else {return}
        guard let imageData = UIImagePNGRepresentation(image) else { return }
        let dataContainer : Dictionary<String,Any> = [self.today! : ["content": content, "image": imageData]]
        diaryStore.addDiary(dataContainer)
        let mainView = storyboard?.instantiateViewController(withIdentifier: "viewController") as? ViewController
        self.show(mainView!, sender: self)
    }
}

extension WriteViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        thumbnail.setImage(selectedImage, for: UIControlState.normal)
        imageContainer = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
