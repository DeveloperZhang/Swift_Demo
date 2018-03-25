//
//  ViewController.swift
//  HelloWorld
//
//  Created by mac on 17/8/11.
//  Copyright © 2017年 DeveloperZhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let name = "Jim";
        print("name is \(name)");
        
        let optionalInteger: Int? = 42;
        let optionalInteger2: Int! = nil;
        let optionalInteger3: Int! = optionalInteger2;

        
        print("optionalInteger is \(String(describing: optionalInteger))")
        print("optionalInteger2 is \(optionalInteger2)")
        print("optionalInteger3 is \(optionalInteger3)")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

