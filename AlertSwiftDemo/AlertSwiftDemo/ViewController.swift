//
//  ViewController.swift
//  AlertSwiftDemo
//
//  Created by Vicent on 2018/7/16.
//  Copyright © 2018年 VicentZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickAction(_ sender: Any) {
        let alertView: VZAlertView = VZAlertView.showAlert();
        alertView.titleString = "我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题";
        alertView.contentString = "我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容";
    }
    
}

