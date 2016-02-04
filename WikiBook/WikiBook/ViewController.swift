//
//  ViewController.swift
//  jsInjectTest
//
//  Created by Ankita on 10/12/15.
//  Copyright © 2015 Ankita. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIWebViewDelegate,UIActionSheetDelegate,InputViewProtocol {
    @IBOutlet var webview:UIWebView?
    @IBOutlet var startbtn:UIButton?
    var currentBookName:String?
    var chapters:NSArray?
    var state:Bool?
    @IBAction func buttonClick(){
        if !(state!) {return}
        if (startbtn?.selected)! as Bool {
            let path = NSBundle.mainBundle().pathForResource("second", ofType: "js")
            var text:NSString?
            do
            {
                text = try NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
            }
            catch
            {
                text = ""
            }
            let result=((self.webview?.stringByEvaluatingJavaScriptFromString((text! as String)+"getData();"))!as String)
            print(result)
            let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
            let writePath = documents.stringByAppendingString("/book.plist")
            print(writePath);
            var data:NSString?
            data = NSArray(contentsOfFile: writePath)?.componentsJoinedByString(":::")
            if data == nil{
                self.chapters=result.componentsSeparatedByString(":::")
            }else{
                self.chapters=((data! as String)+":::"+result).componentsSeparatedByString(":::")
            }
            chapters!.writeToFile(writePath, atomically: true)
            startbtn?.selected=false
            self.webview?.reload()
        }else{
            startbtn?.selected=true
            let path = NSBundle.mainBundle().pathForResource("second", ofType: "js")
            var text:NSString?
            do
            {
                text = try NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
            }
            catch
            {
                text = ""
            }
            self.webview?.stringByEvaluatingJavaScriptFromString((text! as String)+"init();")
            print(text!)
        }
          
    }
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int)
    {
        switch buttonIndex{
            
        case 0:
            let newBookView:InputView=InputView(frame: self.view.frame)
            newBookView.delegate=self
            self.view.addSubview(newBookView)
            
            break;
        case 1:
            NSLog("Existing Book");
            break;
            default:
            NSLog("Default");
            break;
            //Some code here..
            
        }
    }
    //var strUrl="https://en.wikipedia.org/wiki/Sachin_Tendulkar"
    var strUrl="https://en.wikipedia.org"
    override func viewDidLoad() {
        super.viewDidLoad()
        state=false
        // Do any additional setup after loading the view, typically from a nib.
        let myurl=NSURL(string: strUrl)
        
       let request=NSURLRequest(URL: myurl!)
        self.webview?.loadRequest(request)
        self.webview?.delegate=self
        
    }
    
    @IBAction func chooseBook(){
        let actionSheet = UIActionSheet(title: "Choose Book", delegate: self, cancelButtonTitle: "Existing", destructiveButtonTitle: "New")
        actionSheet.showInView(self.view)
    
    }
    
    func processTextInImage(inputArr:NSMutableArray)->String{
        var currentSize:Float=0.0
        var resultStr:String?
        for(var i=0;i<inputArr.count;i++){
            if let ns_str:NSString = inputArr.objectAtIndex(i) as? NSString {
                if ns_str.rangeOfString("[image]").location<0{
                    let sizeOfString = ns_str.boundingRectWithSize(
                        CGSizeMake(414.0, CGFloat.infinity),
                        options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                        attributes: [NSFontAttributeName:"System"],context: nil).size
                    currentSize=currentSize+Float(sizeOfString.height)
                    if currentSize<736.0{
                        resultStr=resultStr!+"\n"+String(ns_str)
                    }else{
                        resultStr=resultStr!+":::"+String(ns_str)
                    }
                }else{
                    resultStr=resultStr!+":::"+String(ns_str)
                }
            }
        }
        return resultStr!
    }
    
    @IBAction func readClick(){
        let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        let readPath = documents.stringByAppendingString("/book.plist")
        
        print(readPath);
        let myreaderview=myReaderView(frame: self.view.frame)
        self.view.addSubview(myreaderview)
        myreaderview.chapter=NSArray(contentsOfFile: readPath)
        myreaderview.load()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("Webview fail with error \(error)");
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print(request.mainDocumentURL?.absoluteString)
    return true;
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        print("Webview started Loading")
        state=false
        self.webview?.userInteractionEnabled=false
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
       // var error:NSError?
          state=true
        
        self.webview?.userInteractionEnabled=true
    
        print("Webview did finish load")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
       
    
    func setNewName(name: String) {
        self.currentBookName=name
        print(self.currentBookName!)
    }

}

