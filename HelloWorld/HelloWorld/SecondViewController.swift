//
//  SecondViewController.swift
//  HelloWorld
//
//  Created by Vicent on 2018/2/26.
//  Copyright © 2018年 DeveloperZhang. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    enum DaysOfAWeek {
        case Sunday
        case Monday
        case TUESDAY
        case WEDNESDAY
        case THURSDAY
        case FRIDAY
        case Saturday
    }
    
    var weekDay = DaysOfAWeek.THURSDAY
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weekDay = .THURSDAY
        switch weekDay {
            case .Sunday:
                print("星期天")
            case .Monday:
                print("星期一")
            case .TUESDAY:
                print("星期二")
            case .WEDNESDAY:
                print("星期三")
            case .THURSDAY:
                print("星期四")
            case .FRIDAY:
                print("星期五")
            case .Saturday:
                print("星期六")
        }
        
        enum Student {
            case Name(String)
            case Mark(Int,Int,Int)
        }
        let stuDetails = Student.Name("Runoob")
//        let stuMarks = Student.Mark(98,97,95)
        switch stuDetails {
        case .Name(let stuName):
            print("学生的名字是:\(stuName)")
        case .Mark(let mark1,let mark2,let mark3):
            print("学生的成绩是:\(mark1),\(mark2),\(mark3)")
        }
        
        enum Month:Int {
            case January = 1, February, March
        }
        let yearMonth = Month.March.rawValue
        print("数字月份为：\(yearMonth)")
    }
}
