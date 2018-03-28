//
//  ThirdViewController.swift
//  HelloWorld
//
//  Created by Vicent on 2018/3/13.
//  Copyright © 2018年 DeveloperZhang. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        struct MarkStruct {
            var mark1: Int
            var mark2: Int
        }
        let marks = MarkStruct(mark1:10,mark2:20)
        print("marks.mark1:\(marks.mark1)")
        print("marks.mark2:\(marks.mark2)")
        
        struct MarkStruct2 {
            var mark1 = 100
            var mark2 = 90
        }
        let marks1 = MarkStruct2()
        print("marks1.mark1:\(marks1.mark1)")
        print("marks1.mark2:\(marks1.mark2)")
        
        struct StuMarks {
            static let markCount = 97
            static var totalCount = 0
            var InternalMarks: Int = 0 {
                didSet {
                    if InternalMarks > StuMarks.markCount {
                        InternalMarks = StuMarks.markCount
                    }
                    if InternalMarks > StuMarks.totalCount {
                        StuMarks.totalCount = InternalMarks
                    }
                }
            }
        }
        
        var stud1Mark1 = StuMarks()
        var stud1Mark2 = StuMarks()
        
        print("StuMarks.totalCount\(StuMarks.totalCount)")
        stud1Mark1.InternalMarks = 98
        print(stud1Mark1.InternalMarks)
        print(StuMarks.totalCount)
        
        print("StuMarks.totalCount\(StuMarks.totalCount)")
        stud1Mark2.InternalMarks = 87
        print(stud1Mark2.InternalMarks)
        print(StuMarks.totalCount)
        
        let amount = funcName(amount: 10)
        print("amount :\(amount)")
        
        struct Matrix {
            let rows: Int, columns: Int
            var print: [Double]
            init(rows: Int, columns: Int) {
                self.rows = rows
                self.columns = columns
                print = Array(repeating: 0.0, count: rows * columns)
            }
            subscript(row: Int, column: Int) -> Double {
                get {
                    return print[(row * columns) + column]
                }
                set {
                    print[(row * columns) + column] = newValue
                }
            }
        }
        
        var mat = Matrix(rows:3, columns:3)
        mat[0,0] = 1.0
        mat[0,1] = 2.0
        mat[1,0] = 3.0
        mat[1,1] = 5.0
        
        print("mat[0,0]:\(mat[0,0])")
        print("mat[0,1]:\(mat[0,1])")
        print("mat[1,0]:\(mat[1,0])")
        print("mat[1,1]:\(mat[1,1])")
    }
    
    func funcName(amount: Int) -> Int {
        var result = 0
        if amount > 0 {
            result = amount
        }
        return result
    }
    
    static func abs(number: Int) ->Int {
        if number < 0 {
            return (-number)
        } else {
            return number
        }
    }
}
