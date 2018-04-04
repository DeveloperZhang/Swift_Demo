//
//  MyView.swift
//  CustomUIDemo
//
//  Created by mac on 2018/4/4.
//  Copyright © 2018年 DeveloperZhang. All rights reserved.
//

import UIKit

protocol MyViewDataSource {
    func numberOfSubViews()->NSInteger
    func frameAtIndexPath(outIndexPath indexPath:NSIndexPath)->CGRect
    func subViewAtIndexPath(_ indexPath:NSIndexPath)->UIView
}

class MyView: UIView {
    
    var contentView = UIView.init()
    var subViewsMutableArray = NSMutableArray.init()
    var dataSource:AnyClass?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
