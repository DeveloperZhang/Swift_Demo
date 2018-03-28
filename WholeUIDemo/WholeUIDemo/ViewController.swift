//
//  ViewController.swift
//  WholeUIDemo
//
//  Created by Vicent on 2018/3/28.
//  Copyright © 2018年 VicentZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let sectionArray = ["First Steps":["UIView"],"Container Views":["Collection Views","Table Views","UIStackView","UIScrollView"],"Content Views":["UIActivityIndicatorView","UIImageView","UIPickerView","UIProgressView","UIWebView"],"Controls":["UIControl","UIButton","UIDataPicker","UIPageControl","UISegmentControl","UISlider","UIStepper","UISwitch"],"Text Views":["UILabel","UITextField","UITextView"],"Bars":["UIBarItem","UIBarButtonItem","UIBarButtonItemGroup","UINavigationBar","UISearchBar","UIToolBar","UITabBar","UITabBarItem","UIBarPositioning","UIBarPositioningDelegate"],"Menus":["UIMenusController","UIMenuItem"],"Visual Adornments":["UIVisualEffect","UIVisualEffectView","UIVibrancyEffect","UIBlurEffect"],"Appearance Customization":["UIAppearance","UIAppearanceContainer"],"Related Types":["UIEdgeInsets","NSDirectionalEdgeInsets","UIOffset"]]
    var keys:Array<String> = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        keys = Array(sectionArray.keys);
        print("");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = sectionArray[keys[section]];
        return (array?.count)!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        let array = sectionArray[keys[indexPath.section]];
        let title = array![indexPath.row] //获取应用名
        cell.textLabel!.text = title
        return cell
    }
}

