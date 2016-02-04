//
//  ListView.swift
//  jsInjectTest
//
//  Created by Ankita on 04/01/16.
//  Copyright © 2016 Ankita. All rights reserved.
//

import UIKit

class ListView: UIView,UITableViewDataSource,UITableViewDelegate {
    let table:UITableView=UITableView()
    var books=NSArray()
    override init(frame: CGRect) {
        super.init( frame: frame)
       // self.table.frame=CGRectMake(100, 100, 100, 30)
        self.table.backgroundColor=UIColor.redColor()
        self.addSubview(self.table)
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return books.count    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "mycell")
        cell.textLabel?.text = books.objectAtIndex(indexPath.row).valueForKey("title") as! NSString as String
        cell.detailTextLabel?.text = books.objectAtIndex(indexPath.row).valueForKey("date") as! NSString as String
        return cell as UITableViewCell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
        let mytitle=books.objectAtIndex(indexPath.row).valueForKey("title") as! NSString as String
        let myDate=books.objectAtIndex(indexPath.row).valueForKey("date") as! NSString as String
        let alert=UIAlertView(title: myDate, message: mytitle, delegate: nil, cancelButtonTitle: "ok", otherButtonTitles:"")
        alert.show()
    }

}
