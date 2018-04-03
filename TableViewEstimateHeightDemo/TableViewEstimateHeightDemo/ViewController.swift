//
//  ViewController.swift
//  TableViewEstimateHeightDemo
//
//  Created by Vicent on 2018/4/3.
//  Copyright © 2018年 VicentZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.register(UINib(nibName: "MyTestTableViewCell", bundle: nil), forCellReuseIdentifier: "MyTestTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MyTestTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyTestTableViewCell", for: indexPath) as! MyTestTableViewCell
        if indexPath.row == 1 {
            cell.myLabel.text = "123456"
        }else {
            cell.myLabel.text = "LabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabel"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}


