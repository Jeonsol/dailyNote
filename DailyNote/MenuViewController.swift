//
//  MenuViewController.swift
//  DailyNote
//
//  Created by 전솔 on 2018. 7. 22..
//  Copyright © 2018년 전솔. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44.0
        tableView.tableFooterView = UIView()
        //tableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }
}

extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuViewCell
        
        if indexPath.row == 1 {
            cell.textLabel?.text = "검색"
            cell.menuImage.image = UIImage(named: "icon_search_32x32_gray")
        } else if indexPath.row == 2 {
            cell.textLabel?.text = "모아보기"
            cell.menuImage.image = UIImage(named: "icon_document_32x32_gray")
        } else if indexPath.row == 3 {
            cell.textLabel?.text = "오늘 이야기"
            cell.menuImage.image = UIImage(named: "icon_earth_32x32_gray")
        }
        else if indexPath.row == 4 {
            cell.textLabel?.text = "설정"
            cell.menuImage.image = UIImage(named: "icon_setting_32x32_gray")
        }
        return cell
    }
}
