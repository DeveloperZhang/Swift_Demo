//
//  VZGradientProgressView.swift
//  VZGradientSwiftProgress
//
//  Created by Vicent on 2018/7/18.
//  Copyright © 2018年 VicentZ. All rights reserved.
//

import UIKit

class VZGradientProgressView: UIView {
    /**
     *  进度条背景颜色  默认是 （230, 244, 245）
     */
    var bgProgressColor: UIColor?
    /**
     *  进度条渐变颜色数组，颜色个数>=2
     *  默认是 @[(id)VZRGBColor(252, 244, 77).CGColor,(id)VZRGBColor(252, 93, 59).CGColor]
     */
    var storeColorArr: Array<Any>?
    var colorArr: Array<Any>? {
        set {
            if (newValue?.count)! >= 2 {
                storeColorArr = newValue;
                self.updateView();
            } else {
                print(">>>>>颜色数组个数小于2，显示默认颜色")
            }
        }
        get {
            return storeColorArr;
        }
    }
    /**
     *  进度 默认是0.2
     */
    var storeProgress: CGFloat?
    var progress: CGFloat? {
        set {
            storeProgress = newValue;
            self.updateView();
        }
        get {
            return storeProgress
        }
    }
    
    var bgLayer: CALayer?
    
    var gradientLayer: CAGradientLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.bgProgressColor = VZGradientProgressView.rgbColor(r: 230.0, g: 244.0, b: 245.0);
        self.colorArr = [VZGradientProgressView.rgbColor(r: 252.0, g: 244.0, b: 77.0).cgColor,VZGradientProgressView.rgbColor(r: 252.0, g: 93.0, b: 59.0).cgColor];
        self.progress = 0.25
        self.addSubViewTree();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configBgLayer() {
        if bgLayer == nil {
            bgLayer = CALayer();
            bgLayer?.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height);
            bgLayer?.backgroundColor = bgProgressColor?.cgColor;
            bgLayer?.cornerRadius = self.frame.height/2.0;
            layer.addSublayer(bgLayer!);
        }
    }
    
    func configGradientLayer() {
        if gradientLayer == nil {
            gradientLayer = CAGradientLayer();
            gradientLayer?.frame = CGRect(x: 0, y: 0, width: frame.width * progress!, height: frame.height);
            gradientLayer?.startPoint = CGPoint(x:0, y:0)
            gradientLayer?.endPoint = CGPoint(x:1, y:0)
            gradientLayer?.colors = colorArr;
            gradientLayer?.cornerRadius = self.frame.height/2.0;
            layer.addSublayer(gradientLayer!);
        }
    }
    
    func addSubViewTree() {
        self.configBgLayer();
        self.configGradientLayer()
    }
    
    func updateView() {
        gradientLayer?.frame = CGRect(x: 0, y: 0, width: frame.size.width * progress!, height: frame.height);
        gradientLayer?.colors = self.colorArr;
    }
    
    //颜色转换
    class func rgbColor(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        let color = UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0);
        return color;
    }
}
