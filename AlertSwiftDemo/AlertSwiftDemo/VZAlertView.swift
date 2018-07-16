//
//  VZAlertView.swift
//  AlertSwiftDemo
//
//  Created by Vicent on 2018/7/16.
//  Copyright © 2018年 VicentZ. All rights reserved.
//

import UIKit

let AlertW = 280.0
let XSpace = 10.0

class VZAlertView: UIView {
    private var alertView: UIView?
    private var sureButton: UIButton?
    private var titleLabel: UILabel?
    private var contentLabel: UILabel?
    var storeTitleString: String?;
    var titleString: String? {
        set {
            if self.titleLabel == nil {
                self.getAdaptiveLabel(rect: CGRect(x:2 * XSpace, y:2 * XSpace, width:AlertW - 2 * 2 * XSpace, height:50.0), text: newValue! , isTitle: true);
            }
            self.storeTitleString = newValue;
            self.refreshUI();
        }
        get {
            return self.storeTitleString;
        }
    }
    var storeContentString: String?;
    var contentString: String? {
        set {
            if self.contentLabel == nil {
                var frame: CGRect = CGRect(x:2 * XSpace, y:2 * XSpace, width:AlertW - 2 * 2 * XSpace, height:300);
                if self.titleLabel != nil {
                    frame = CGRect(x:2 * XSpace, y: Double(XSpace + (Double)((self.titleLabel?.frame.maxY)!)), width:AlertW - 2 * 2 * XSpace, height:300);
                }
                self.getAdaptiveLabel(rect:frame, text: newValue! , isTitle: false);
            }
            self.storeContentString = newValue;
            self.refreshUI();
        }
        get {
            return self.storeContentString;
        }
    }
    var storeButtonString: String?;
    var buttonString: String?
    {
        set {
            if self.sureButton == nil {
                let button: UIButton = UIButton.init(type: UIButtonType.custom);
                button.frame = CGRect(x: 0, y: 0, width: AlertW, height: 30);
                button.backgroundColor = UIColor.green;
                button.addTarget(self, action: #selector(VZAlertView.buttonAction), for: UIControlEvents.touchUpInside)
                self.sureButton = button;
                self.alertView?.addSubview(button)
            }
            self.sureButton?.setTitle(newValue, for: UIControlState.normal)
            self.storeButtonString = newValue;
        }
        get {
            return self.storeButtonString;
        }
    }
    
    func refreshUI() {
        let y1: CGFloat = (self.titleLabel?.frame.maxY)!;
        var y2: CGFloat = 0.0;
        if self.contentLabel != nil {
            y2 = (self.contentLabel?.frame.maxY)!;
        }
        var y: Double = Double(y1 > y2 ? y1 : y2);
        let y3: Double = y + XSpace;
        if self.sureButton != nil {
            self.sureButton?.frame = CGRect(x: 2 * XSpace, y: y3, width: AlertW - 4 * XSpace, height: 44);
            y = Double((self.sureButton?.frame.maxY)!) + 2 * XSpace;
        } else {
            y += 2 * XSpace;
        }
        self.alertView?.frame = CGRect(x: 0, y: 0, width: AlertW, height: y)
        self.alertView?.center = self.center;
    }
    
    class func showAlert() -> VZAlertView {
        let alertView: VZAlertView = VZAlertView.init(frame: UIScreen.main.bounds);
        alertView.backgroundColor = UIColor.black.withAlphaComponent(0.5);
        let contentView: UIView = UIView();
        alertView.alertView = contentView;
        contentView.layer.cornerRadius = 8.0;
        alertView.alertView?.frame = CGRect(x: 0, y: 0, width: AlertW, height: 100);
        contentView.backgroundColor = UIColor.white;
        contentView.center = alertView.center;
        alertView.buttonString = "OK";
        alertView.addSubview(contentView);
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate;
        let window: UIWindow = delegate.window!;
        window.addSubview(alertView);
        return alertView;
    }
    
    @objc func buttonAction() {
        self.removeFromSuperview();
    }
    
    func getAdaptiveLabel(rect: CGRect, text: String, isTitle: Bool) {
        var contentLabel: UILabel?;
        if isTitle {
            if self.titleLabel != nil {
                contentLabel = self.titleLabel;
            } else {
                contentLabel = UILabel.init(frame: rect)
                self.titleLabel = contentLabel;
            self.alertView?.addSubview(contentLabel!);
            }
        } else {
            if self.contentLabel != nil {
                contentLabel = self.contentLabel;
            } else {
                contentLabel = UILabel.init(frame: rect)
                self.contentLabel = contentLabel;
                self.alertView?.addSubview(contentLabel!);
            }
        }
        contentLabel?.numberOfLines = 0;
        contentLabel?.text = text;
        if isTitle {
            contentLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        } else {
            contentLabel?.font = UIFont.systemFont(ofSize: 14.0)
        }
        let mAttrStr: NSMutableAttributedString = NSMutableAttributedString.init(string:text);
        let mParaStyle: NSMutableParagraphStyle = NSMutableParagraphStyle.init();
        mParaStyle.lineBreakMode = NSLineBreakMode.byCharWrapping;
        mParaStyle.alignment = NSTextAlignment.center;
        mParaStyle.lineSpacing = 3.0;
    mAttrStr.addAttribute(NSAttributedStringKey.paragraphStyle, value: mParaStyle, range: NSMakeRange(0, text.count))
        contentLabel?.attributedText = mAttrStr;
        if rect.height > 200 {
            contentLabel?.sizeToFit();
            contentLabel?.frame = CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: (contentLabel?.frame.size.height)!)
        }
    }
}







