//
//  InputView.swift
//  jsInjectTest
//
//  Created by Ankita on 03/01/16.
//  Copyright © 2016 Ankita. All rights reserved.
//

import UIKit
protocol InputViewProtocol {
    func setNewName(name:String)
}
class InputView: UIView {
    let textField:UITextField=UITextField()
    let closeBtn:UIButton=UIButton()
    var delegate:InputViewProtocol?
    override init(frame: CGRect) {
        super.init( frame: frame)
        self.textField.frame=CGRectMake(100, 100, 100, 30)
        self.textField.backgroundColor=UIColor.redColor()
        self.addSubview(self.textField)
        self.closeBtn.frame=CGRectMake(354, 0, 60, 30)
        self.addSubview(self.closeBtn)
        closeBtn.setTitle("Close", forState: .Normal)
        closeBtn.setTitleColor(UIColor.blueColor(), forState: .Normal)
        //previous.setImage(UIImage(named: "previous.png"), forState: UIControlState.Normal)
        closeBtn.addTarget(self, action: "closeClick:", forControlEvents: .TouchUpInside)
        self.backgroundColor=UIColor.whiteColor()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    @IBAction func closeClick(sender:UIButton){
        self.delegate?.setNewName(self.textField.text!)
        self.removeFromSuperview()
    }
    
}
