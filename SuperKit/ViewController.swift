//
//  ViewController.swift
//  SuperKit
//
//  Created by maiziedu on 11/9/15.
//  Copyright © 2015 Alatan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 输入框
    @IBOutlet weak var textField: UITextField!
    
    // 显示查询结果
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // 查询手机号归属地
    @IBAction func QueryButtonPressed(sender: UIButton) {
        
        // 第一步验证,怕断是否为空 nil
        if textField.text?.isEmpty == true {
            return
        }
        
        // 第二步：需要验证手机号格式，用正则表达式 TODO
        
        
        
        // 隐藏掉键盘
        textField.resignFirstResponder()
        
        
        // 网址
        let url: NSURL = NSURL(string: "http://api.k780.com:88/?app=phone.get&phone=\(textField.text!)&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json")!
        let request: NSURLRequest = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            
            
            if (error != nil) {
                
                NSLog("发生错误")
            } else {
                let responseString = NSString.init(data: data!, encoding: NSUTF8StringEncoding)
                NSLog("请求成功\n\(responseString)")  // json  字符串
                
                do
                {
                    // json 字符串 转 dictionary
                    let json = (try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)) as! NSDictionary
                    
                    // M
                    let model: DataModel = DataModel()
                    model.phoneNum = json["result"]!["att"] as? String
                    model.yunYingShang = json["result"]!["operators"] as? String
                    
                    // key - value
                    self.addressLabel.text = model.phoneNum
                    self.companyLabel.text = model.yunYingShang
                    


                    
                } catch {
                    
                }
                
            }
        }
    }
    
    // 清楚输入框内容
    @IBAction func ClearButtonPressed(sender: UIButton) {
        
        textField.text = ""
        textField.placeholder = "请输入手机号..."
    }
}

