//
//  ViewController.swift
//  UIKitDemo
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 DeveloperZhang. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var uiArray:NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiArray = ["UIView"];
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (uiArray?.count)!;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let text:String = "\(uiArray![indexPath.row])"
        cell.textLabel?.text = text
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc:TestViewViewController = TestViewViewController(nibName: "TestViewViewController", bundle: nil)
            vc.title = "\(uiArray![indexPath.row])"
            self.navigationController?.pushViewController(vc, animated: true)
            return
        default:
            return
        }
    }
}

