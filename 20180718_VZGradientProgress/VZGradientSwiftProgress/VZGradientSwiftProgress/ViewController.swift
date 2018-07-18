//
//  ViewController.swift
//  VZGradientSwiftProgress
//
//  Created by Vicent on 2018/7/18.
//  Copyright © 2018年 VicentZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let progressView: VZGradientProgressView = VZGradientProgressView.init(frame: CGRect(x: 0, y: 0, width: 300, height: 5));
        progressView.center = self.view.center;
        view.addSubview(progressView);
        progressView.progress = 0.9;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

