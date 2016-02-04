//
//  myReaderView.swift
//  jsInjectTest
//
//  Created by Ankita on 12/12/15.
//  Copyright © 2015 Ankita. All rights reserved.
//

import UIKit

class myReaderView: UIView {
    var previous:UIButton!
    var next:UIButton!
    var txt:UITextView?
    var img:UIImageView?
    var back:UIButton!
    var chapter:NSArray?///spelling was wrong
    var currentChapter:Int?
    override init(frame: CGRect) {
        super.init( frame: frame)
        previous=UIButton()
        next=UIButton()
        back=UIButton()
        txt=UITextView()
        img=UIImageView()
        
        self.backgroundColor=UIColor.whiteColor()
        previous.frame=CGRectMake(0,350,36,36)
        next.frame=CGRectMake(378, 350, 36, 36)
        back.frame=CGRectMake(0, 0, 50, 36)
        txt?.frame=CGRectMake(0,30 , 414, 696)
        img?.frame=CGRectMake(0,30 , 414, 696)
        img?.hidden=true
        img?.contentMode = .ScaleAspectFit

       // previous.setTitle("<<", forState: .Normal)
        //previous.setTitleColor(UIColor.blueColor(), forState: .Normal)
        previous.setImage(UIImage(named: "previous.png"), forState: UIControlState.Normal)
        previous.addTarget(self, action: "previousClick:", forControlEvents: .TouchUpInside)
        //next.setTitle(">>", forState: .Normal)
        //next.setTitleColor(UIColor.blueColor(), forState: .Normal)
        next.setImage(UIImage(named: "next.png"), forState: UIControlState.Normal)
        next.addTarget(self, action: "nextClick:", forControlEvents: .TouchUpInside)
        back.setImage(UIImage(named: "back.png"), forState: UIControlState.Normal)
        back.addTarget(self, action: "backClick:", forControlEvents: .TouchUpInside)
        //txt?.backgroundColor=UIColor.blackColor()
        self.addSubview(txt!)
        self.addSubview(img!)
        self.addSubview(previous)
        self.addSubview(next)
        self.addSubview(back)

    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
}
    
    
    @IBAction func previousClick(sender:UIButton){
        if currentChapter>0{
        currentChapter=currentChapter!-1
            let data:String=(chapter?.objectAtIndex(currentChapter!)) as! String
            if data.containsString("[Image]"){
             //load Image herestr
                let url=NSURL(string: data.stringByReplacingOccurrencesOfString("[Image]", withString: ""))
                let imgdata=NSData(contentsOfURL: url!)
                let image=UIImage(data: imgdata!)
                img?.image=image
                img?.hidden=false
                txt?.hidden=true
                
                
            }else{
                txt!.text=data
                img?.hidden=true
                txt?.hidden=false
                /*if txt?.text != nil {
                    if (((self.txt?.text!)! as NSString).respondsToSelector(Selector("sizeWithAttributes:"))){
                        let size = ((self.txt?.text!)! as NSString).sizeWithAttributes([NSFontAttributeName:(self.txt?.font)!])
                        print(size)
                    }
                }*/
                /*if let ns_str:NSString = txt?.text as NSString? {
                    
                    let sizeOfString = ns_str.boundingRectWithSize(
                        CGSizeMake((self.txt?.frame.size.width)!, CGFloat.infinity),
                        options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                        attributes: [NSFontAttributeName: (txt?.font)!],
                        context: nil).size
                    print(sizeOfString)
                }*/
            }
        }
        
}
     @IBAction func nextClick(sender:UIButton){
        if currentChapter<(chapter?.count)!-1{
        currentChapter=currentChapter!+1
            let data:String=(chapter?.objectAtIndex(currentChapter!)) as! String
            if data.containsString("[Image]"){
                //load Image herestr
                let url=NSURL(string: data.stringByReplacingOccurrencesOfString("[Image]", withString: ""))
                let imgdata=NSData(contentsOfURL: url!)
                let image=UIImage(data: imgdata!)
                img?.image=image
                img?.hidden=false
                txt?.hidden=true
                
            }else{
                txt!.text=data
                img?.hidden=true
                 txt?.hidden=false
                /*if let ns_str:NSString = txt?.text as NSString? {
                    
                    let sizeOfString = ns_str.boundingRectWithSize(
                        CGSizeMake((self.txt?.frame.size.width)!, CGFloat.infinity),
                        options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                        attributes: [NSFontAttributeName: (txt?.font)!],
                        context: nil).size
                    print(sizeOfString)
                }*/
                /*if txt?.text != nil {
                    if (((self.txt?.text!)! as NSString).respondsToSelector(Selector("sizeWithAttributes:"))){
                      let size = ((self.txt?.text!)! as NSString).sizeWithAttributes([NSFontAttributeName:(self.txt?.font)!])
                        print(size)
                    }
                }*/
            }
        }
    }
     @IBAction func backClick(sender:UIButton){
        self.removeFromSuperview()
        
        
        
    }
    func load(){
        currentChapter=0
        txt!.text=(chapter?.objectAtIndex(currentChapter!)) as! String
    
    }

}
