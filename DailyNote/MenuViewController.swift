//
//  MenuViewController.swift
//  DailyNote
//
//  Created by 전솔 on 2018. 7. 24..
//  Copyright © 2018년 전솔. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var interactor : Interactor?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func edgePandGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        let progress = MenuHelper.calculateProgress(translationInView: translation, viewBounds: view.bounds, direction: .left)
        
        MenuHelper.mapGestureStateToInteractor(gestureState: sender.state, progress: progress, interactor: interactor) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func dismissSlideMenu(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "111"
        
        return cell!
    }
}
