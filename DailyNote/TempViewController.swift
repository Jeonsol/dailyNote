//
//  TempViewController.swift
//  DailyNote
//
//  Created by 전솔 on 2018. 8. 4..
//  Copyright © 2018년 전솔. All rights reserved.
//

import UIKit

class TempViewController: UIViewController {

    @IBOutlet weak var stackview: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()

        var imageView : UIImageView
        imageView  = UIImageView(frame:CGRect(x: 0, y: 0, width: 10, height: 10));
        imageView.image = UIImage(named:"차은우")
        imageView.contentMode = .scaleAspectFit
        
        stackview.insertArrangedSubview(imageView, at: 0)
    }


}
