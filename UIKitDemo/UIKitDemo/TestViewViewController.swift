//
//  TestViewViewController.swift
//  UIKitDemo
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 DeveloperZhang. All rights reserved.
//

import UIKit

class TestViewViewController: UIViewController {

    @IBOutlet weak var subView1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let next = self.subView1.next
        let next1 = self.view.next
        print("")
    }
}
