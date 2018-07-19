//
//  ViewController.swift
//  VZLoaderDisplaySwift
//
//  Created by Vicent on 2018/7/18.
//  Copyright © 2018年 VicentZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var closedIndicator: VZDownloadIndicator?
    var filledIndicator: VZDownloadIndicator?
    var mixedIndicator: VZDownloadIndicator?
    var downloadedBytes: CGFloat?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let height = floor((UIScreen.main.bounds.height - 20 * 2 - 10 * 2)/3)
        print("height is:\(height)");
        let x = (UIScreen.main.bounds.width - height)/2;
        self.downloadedBytes = 0;

        let closedIndicator: VZDownloadIndicator = VZDownloadIndicator.init(frame: CGRect(x: x, y: 20, width: height, height: height), type: VZIndicatorType.Closed);
        closedIndicator.backgroundColor = UIColor.white;
        closedIndicator.fillColor = ViewController.rgbColor(red: 16, green: 119, blue: 234)
        closedIndicator.strokeColor = ViewController.rgbColor(red: 16, green: 119, blue: 234)
        closedIndicator.radiusPercent = 0.45;
        self.closedIndicator = closedIndicator;
        view.addSubview(closedIndicator)
        closedIndicator.loadIndicator();
        closedIndicator.animationDuration = 3.0
        
        let filledIndicator: VZDownloadIndicator = VZDownloadIndicator.init(frame: CGRect(x: x, y: 10 + closedIndicator.frame.maxY, width: height, height: height), type: VZIndicatorType.Filled);
        filledIndicator.backgroundColor = UIColor.white;
        filledIndicator.fillColor = ViewController.rgbColor(red: 16, green: 119, blue: 234)
        filledIndicator.strokeColor = ViewController.rgbColor(red: 16, green: 119, blue: 234)
        filledIndicator.radiusPercent = 0.45;
        self.filledIndicator = filledIndicator;
        view.addSubview(filledIndicator)
        filledIndicator.loadIndicator();
        filledIndicator.animationDuration = 3.0
        
        
        let mixedIndicator: VZDownloadIndicator = VZDownloadIndicator.init(frame: CGRect(x: x, y: 10 + filledIndicator.frame.maxY, width: height, height: height), type: VZIndicatorType.Mixed);
        mixedIndicator.backgroundColor = UIColor.white;
        mixedIndicator.fillColor = ViewController.rgbColor(red: 16, green: 119, blue: 234)
        mixedIndicator.strokeColor = ViewController.rgbColor(red: 16, green: 119, blue: 234)
        mixedIndicator.radiusPercent = 0.45;
        self.mixedIndicator = mixedIndicator;
        view.addSubview(mixedIndicator)
        mixedIndicator.loadIndicator();
        mixedIndicator.animationDuration = 3.0
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.updateView(val: 100);
        }
        
    }
    
    class func rgbColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }

    func updateView(val: CGFloat) -> Void {
        downloadedBytes = downloadedBytes! + val;
        closedIndicator?.updateWithTotalBytes(bytes: 100, downloadedBytes: downloadedBytes!)
        filledIndicator?.updateWithTotalBytes(bytes: 100, downloadedBytes: downloadedBytes!)
        mixedIndicator?.updateWithTotalBytes(bytes: 100, downloadedBytes: downloadedBytes!)
    }
}

