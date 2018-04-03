//
//  ViewController.swift
//  FunctionalProgrammingDemo
//
//  Created by Vicent on 2018/3/29.
//  Copyright © 2018年 VicentZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var person: Person = Person();
        person = person.eat().drink();
        person = person.eat1()().drink1()();
        person = person.eat2()("饭").drink2()("水");
    }
}

class Person: NSObject{
    func eat() -> Person {
        print("吃")
        return self;
    }
    func drink() -> Person {
        print("喝")
        return self;
    }
    
    func eat1() -> ()->(Person) {
        let block:()->(Person) = {
            ()->(Person) in
            print("eat1")
            return self;
        }
        return block;
    }
    
    func drink1() -> ()->(Person) {
        return {()->(Person) in
            print("drink1")
            return self;
        }
    }
    
    func eat2() -> (String)->(Person) {
        let block:(String)->(Person) = {
            (param:String)->(Person) in
            print("eat\(param)")
            return self;
        }
        return block
    }
    
    
    func drink2() -> (String)->(Person) {
        let block:(String)->(Person) = {
            (param:String)->(Person) in
            print("dink\(param)")
            return self
        }
        return block
    }
}

