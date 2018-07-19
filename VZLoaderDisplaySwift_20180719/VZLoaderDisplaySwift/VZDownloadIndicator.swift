//
//  VZDownloadIndicator.swift
//  VZLoaderDisplaySwift
//
//  Created by Vicent on 2018/7/18.
//  Copyright © 2018年 VicentZ. All rights reserved.
//

import UIKit

enum VZIndicatorType {
    case Closed
    case Filled
    case Mixed
}

class VZDownloadIndicator: UIView {
    var storeRadiusPercent: CGFloat?
    //半径比例
    var radiusPercent: CGFloat? {
        set {
            if type == VZIndicatorType.Closed {
                storeRadiusPercent = 0.5
                return;
            }
            
            if newValue! > CGFloat(0.5) || newValue! < CGFloat(0) {
                return;
            } else {
                storeRadiusPercent = newValue;
            }
        }
        get {
            return storeRadiusPercent;
        }
    }
    var storeFillColor: UIColor?
    //填充颜色
    var fillColor: UIColor? {
        set {
            if type == VZIndicatorType.Closed {
                storeFillColor = UIColor.clear
            } else {
                storeFillColor = newValue;
            }
        }
        get {
            return storeFillColor;
        }
    }
    //画笔颜色
    var strokeColor: UIColor?
    var storeAnimationDuration: CGFloat?
    //动画总时间
    var animationDuration: CGFloat? {
        set {
            storeAnimationDuration = newValue;
        }
        get {
            return storeAnimationDuration;
        }
    }
    //指示器类型
    var type: VZIndicatorType?
    //指示器图层 -- filled和mixed类型
    var indicateShapeLayer: CAShapeLayer?
    //覆盖图层 -- closed类型
    var coverLayer: CAShapeLayer?
    //动画图层
    var animatingLayer: CAShapeLayer?
    //圆环背景色
    var closedIndicatorBackgroundStrokeColor: UIColor?
    //圆环宽度
    var coverWidth: CGFloat?
    //动画路径数组
    var paths: NSMutableArray?
    //上一次更新的路径
    var lastUpdatedPath: UIBezierPath?
    //上一次弧度
    var lastSourceRadian:CGFloat?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        type = VZIndicatorType.Closed;
        initAttributes();
    }
    
    init(frame: CGRect, type: VZIndicatorType) {
        super.init(frame: frame);
        self.type = type;
        initAttributes();
    }
    
    func initAttributes() {
        if type == VZIndicatorType.Closed {
            radiusPercent = 0.5;
            coverLayer = CAShapeLayer();
            animatingLayer = coverLayer;
            
            fillColor = UIColor.clear
            strokeColor = UIColor.white
            closedIndicatorBackgroundStrokeColor = UIColor.gray
            coverWidth = 3.0
        } else {
            if type == VZIndicatorType.Filled {
                indicateShapeLayer = CAShapeLayer();
                animatingLayer = indicateShapeLayer;
                radiusPercent = 0.5;
                coverWidth = 2.0;
            } else {
                indicateShapeLayer = CAShapeLayer();
                coverLayer = CAShapeLayer();
                animatingLayer = indicateShapeLayer;
                radiusPercent = 0.4;
                coverWidth = 2.0;
            }
        }
        
        animatingLayer?.frame = self.bounds;
        layer.addSublayer(animatingLayer!)
        paths = NSMutableArray.init();
        animationDuration = 1.0;
    }
    
    override func draw(_ rect: CGRect) {
        if type == VZIndicatorType.Closed {
            let radius = min(self.bounds.width, self.bounds.height)/2 - coverWidth!
            let center = CGPoint(x:self.bounds.width/2, y:self.bounds.height/2);
            let coverPath = UIBezierPath();
            coverPath.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true);
            closedIndicatorBackgroundStrokeColor?.set()
            coverPath.lineWidth = self.coverWidth!
            coverPath.stroke();
        } else if type == VZIndicatorType.Mixed {
            let radius = min(self.bounds.width, self.bounds.height)/2 - coverWidth!
            let center = CGPoint(x:self.bounds.width/2, y:self.bounds.height/2);
            let coverPath = UIBezierPath();
            coverPath.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true);
            fillColor?.set()
            coverPath.lineWidth = self.coverWidth!
            coverPath.stroke();
        }
    }
    
    func loadIndicator() -> Void {
        //初始化动画layer的路径
        let center = CGPoint(x:self.bounds.width/2, y:self.bounds.height/2);
        let initialPath = UIBezierPath();
        if type == VZIndicatorType.Closed {
            initialPath.addArc(withCenter: center, radius: min(self.bounds.width, self.bounds.height) * radiusPercent!, startAngle: degreeToRadian(degree: -90), endAngle: degreeToRadian(degree: -90), clockwise: true)
        } else {
            if type == VZIndicatorType.Mixed {
                //手动调用drawRect方法?当前情况可以不写
//                self.setNeedsDisplay();
            }
            let radius = min(self.bounds.width, self.bounds.height)/2 * self.radiusPercent!;
            initialPath.addArc(withCenter: center, radius: radius, startAngle: degreeToRadian(degree: -90), endAngle: degreeToRadian(degree: -90), clockwise: true)
        }
        
        animatingLayer?.path = initialPath.cgPath;
        animatingLayer?.strokeColor = strokeColor?.cgColor
        animatingLayer?.fillColor = fillColor?.cgColor
        animatingLayer?.lineWidth = coverWidth!
        //起点为12点方向
        lastSourceRadian = degreeToRadian(degree: -90)
    }
    
    func updateWithTotalBytes(bytes: CGFloat, downloadedBytes:CGFloat) -> Void {
        lastUpdatedPath = UIBezierPath.init(cgPath: (animatingLayer?.path)!)
        paths?.removeAllObjects()
        
        let destinationRadian = destinationAngleForRatio(ratio: (downloadedBytes/bytes))
        let radius = min(self.bounds.width, self.bounds.height) * radiusPercent! - coverWidth!;
        //创建帧动画路径数组
        paths?.addObjects(from: self.keyframePathsWithDuration(dutation: self.animationDuration!, lastUpdateRadian: self.lastSourceRadian!, newRadian: destinationRadian, radius: radius, type: type!))
        //添加动画
        animatingLayer?.path = (paths?[(paths?.count)! - 1] as! CGPath)
        self.lastSourceRadian = destinationRadian
        let pathAnimation = CAKeyframeAnimation.init(keyPath: "path")
        pathAnimation.values = paths as? [Any]
        pathAnimation.duration = Double(self.animationDuration!)
        pathAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        pathAnimation.isRemovedOnCompletion = true
        animatingLayer?.add(pathAnimation, forKey: "path")
    }
    
    func keyframePathsWithDuration(dutation: CGFloat, lastUpdateRadian: CGFloat, newRadian: CGFloat, radius: CGFloat, type: VZIndicatorType) -> Array<Any> {
        
        let frameCount: Int = Int(ceil(dutation * 60));
        let arry: NSMutableArray = NSMutableArray.init(capacity: (frameCount + 1))
        for i in 0...frameCount {
            let startRadian: CGFloat = degreeToRadian(degree: -90);
            let endRadian: CGFloat = lastUpdateRadian + ((newRadian - lastUpdateRadian) * CGFloat(Double(i)))/CGFloat(Double(frameCount))
            //添加动画路径
            let path = self.pathWithStatrAngle(startRadian: startRadian, endRadian: endRadian, radius: radius, type: type)
            arry.add(path.cgPath)
        }
        return arry as! Array<Any>;
    }
    
    func pathWithStatrAngle(startRadian: CGFloat, endRadian: CGFloat, radius: CGFloat, type: VZIndicatorType) -> UIBezierPath {
        let closewise = startRadian <= endRadian;
        let path = UIBezierPath();
        let center = CGPoint(x:self.bounds.width/2, y:self.bounds.height/2)
        if type == VZIndicatorType.Closed {
            path.addArc(withCenter: center, radius: radius, startAngle: startRadian, endAngle: endRadian, clockwise: closewise)
        } else {
            path.move(to: center)
            path.addArc(withCenter: center, radius: radius, startAngle: startRadian, endAngle: endRadian, clockwise: closewise)
        }
        return path;
    }
    
    func degreeToRadian(degree: Double) -> CGFloat {
        return CGFloat((degree * Double.pi)/180.0);
    }
    
    func destinationAngleForRatio(ratio: CGFloat) -> CGFloat {
        return (CGFloat(degreeToRadian(degree: Double((360 * ratio) - 90))));
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
