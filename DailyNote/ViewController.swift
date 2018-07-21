//
//  ViewController.swift
//  DailyNote
//
//  Created by 전솔 on 2018. 7. 17..
//  Copyright © 2018년 전솔. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leadingC: NSLayoutConstraint!
    @IBOutlet weak var trailingC: NSLayoutConstraint!
    @IBOutlet weak var ubeView: UIView!
    
    var hamverMenuIsVisible: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        if !hamverMenuIsVisible {
            leadingC.constant = 450
            trailingC.constant = -450
            
            hamverMenuIsVisible = true
        }
        
        else {
            leadingC.constant = 0
            trailingC.constant = 0
            
            hamverMenuIsVisible = false
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
}

