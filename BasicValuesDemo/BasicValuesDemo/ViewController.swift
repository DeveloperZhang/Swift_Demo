//
//  ViewController.swift
//  BasicValuesDemo
//
//  Created by Vicent on 2018/3/28.
//  Copyright © 2018年 VicentZ. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    let sectionArray = ["Numbers":["Int","Double","Decimal","NumberFormatter"],"Binary Data":["Data"],"URLs":["URL","URLComponents","URLQueryItem"],"Unique Identifiers":["UUID"],"Geometry":["CGFloat","NSPoint","NSSize","NSRect","AffineTransform","NSEdgeInsets"],"Ranges":["NSRange"]]
    var keys:Array<String> = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keys = Array(sectionArray.keys);
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = sectionArray[keys[section]];
        return (array?.count)!
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        let array = sectionArray[keys[indexPath.section]];
        let title = array![indexPath.row] //获取应用名
        cell.textLabel!.text = title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier?.compare("mySegue") == ComparisonResult.orderedSame {
            let indexPath = self.tableView.indexPathForSelectedRow
            let vc = segue.destination as! DetailViewController
            vc.typeString = self.sectionArray[keys[(indexPath?.section)!]]![(indexPath?.row)!];
        }
    }
}

