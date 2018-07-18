//
//  ViewController.swift
//  VZHttpSwiftTool
//
//  Created by Vicent on 2018/7/17.
//  Copyright © 2018年 VicentZ. All rights reserved.
//

import UIKit

enum RequestType {
    case Get
    case Post
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var array: Array<Any>?
    var requestType: RequestType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.array = ["get请求","post请求"];
        
        let cellIdentify: String = "MyTableViewCell";
        tableView.register(UINib.init(nibName: cellIdentify, bundle: nil), forCellReuseIdentifier: cellIdentify)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.array?.count)!;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentify: String = "MyTableViewCell";
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentify)!;
        cell.textLabel?.text = self.array?[indexPath.row] as? String;
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.requestType = RequestType.Get;
            break
        default:
            self.requestType = RequestType.Post;
            break;
        }
        switch self.requestType {
        case .Get?:
            VZHttpTool.get(url: "http://test.imhuasheng.com//app/v2/appVersion/version", urlParamDic: ["id":"1"], successBlock: { (httpResponse) in
                print(httpResponse as Any)
            }, failedBlock: { (httpError) in
                print(httpError as Any)
            })
            break
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    


}






