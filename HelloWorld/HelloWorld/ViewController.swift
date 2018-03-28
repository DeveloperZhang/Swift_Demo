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

        print(testMethod(name: "aaa"))
        print(testMethod1(array:[1,2,3]))
        
        let addition: (Int, Int) -> Int = sum
        print("输出结果: \(addition(40, 89))")
        
        let decrem = calcDecrement(forDecrement: 30)
        print(decrem())
        
        let studname = {print("Swift 闭包实例")}
        studname()
        
        let divide = {(val1: Int,val2: Int) -> Int in
            return val1/val2
        }
        let result = divide(200,20)
        print(result)
        
        let incrementByTen = makeIncrementor(forIncrement: 10)
        print(incrementByTen())
        
        print(incrementByTen())
        
        let alsoIncrementByTen = incrementByTen
        
        print(alsoIncrementByTen())
    }
    
    func testMethod(name: String) -> String {
        return name;
    }
    
    func testMethod1(array:[Int]) -> (min:Int,max:Int) {
        let a: Int = 1;
        let b: Int = 2;
        return (a,b)
    }
    
    func sum(a: Int, b: Int) -> Int {
        return a + b
    }
    
    func calcDecrement(forDecrement total:Int) -> () -> Int {
        var overallDecrement = 0
        func decrementer() -> Int {
            overallDecrement -= total
            return overallDecrement
        }
        return decrementer
    }
    
    func makeIncrementor(forIncrement amount: Int) -> () -> Int {
        var runningToal = 0
        func incrementor() -> Int {
            runningToal += amount
            return runningToal
        }
        return incrementor
    }
}

