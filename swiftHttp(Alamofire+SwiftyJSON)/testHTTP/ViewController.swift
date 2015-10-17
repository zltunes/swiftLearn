//
//  ViewController.swift
//  testHTTP
//
//  Created by  on 15/10/13.
//  Copyright  2015年 . All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet var label1: UILabel!
    
    @IBOutlet var label2: UILabel!
    
    @IBOutlet var label3: UILabel!
    
    @IBOutlet var label4: UILabel!


//测试url:
//http://api.map.baidu.com/telematics/v3/weather?location=合肥&output=json&ak=wl82QREF9dNMEEGYu3LAGqdU
    
    var location : NSString = "合肥"
    
    var output: NSString! = "json"
    
    var ak: NSString = "wl82QREF9dNMEEGYu3LAGqdU"
    
    var url = "http://api.map.baidu.com/telematics/v3/weather"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let params = ["location":location,"output":output,"ak":ak]
        //添加请求头如access_token
        let header = [
              "access_token": "ca4c6848-7347-11e5-936e-00163e021195"
        ]
        
        ///1⃣️向服务端请求json数据：
        
        Alamofire.request(.GET, url, parameters: params,headers:header)
            .responseJSON{ response in
                
                    print("request:\(response.request)")
                    print("response:\(response.response)")
                    print("data:\(response.data)")
                    print("result:\(response.result)")
                
                if (response.result.error == nil){
                    let json = JSON(response.result.value!)
                    
                    //解析为string类型
                    if let date = json["date"].string{
                    self.label1.text = "日期:\(date)"
                    }
                    
                    if let weather = json["results"][0]["weather_data"][0]["weather"].string{
                    self.label2.text = "天气:\(weather)"
                    }
                    
                    //解析为number类型如int
                    if let error = json["error"].int{
                    self.label3.text = "错误:\(error+2)"
                    }
                    
                }else{
                    print(response.result.error)
                }
        }
        
        
        
        
        
        //使用Manager维护session状态
//    //    let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
//    //    let manager = Alamofire.Manager(configuration: configuration)
//        let manager = Alamofire.Manager.sharedInstance
//        manager.request(.GET, NSURLRequest(URL: NSURL(string: url)!), parameters: params)
//            .responseJSON{ response in
//                if (response.result.error == nil){
//                    let json = JSON(response.result.value!)
//                    let suggestion = json["results"][0]["index"][0]["des"].stringValue
//                    self.label4.text = "建议:\(suggestion)"
//                }else{
//                    print(response.result.error)
//                }
//
//    }

        
        
        
        /*
        Alamofire.request(.GET, url, parameters: params)
            .response { request, response, data, error in
                print("1: request:\(request)")
                print("2: response:\(response)")
                print("3: data:\(data)")
                print("4 error:\(error)")
        }
        
        Alamofire.request(.GET, url,parameters: params)
            .responseString { response in
                print("Success: \(response.result.isSuccess)")
                print("Response String: \(response.result.value)")
        }
        
        Alamofire.request(.GET, url,parameters: params)
            .responseJSON { response in
                debugPrint("四:\(response)")
        }
    */
//        2⃣️post 发送json参数
//        let parameters = [
//            "foo": [1,2,3],
//            "bar": [
//                "baz": "qux"
//            ]
//        ]
        
        
        
//        Alamofire.request(.POST, "http://httpbin.org/post", parameters: parameters, encoding: .JSON)
        //不指定encoding将默认URL-Encoded Parameters
        
        
 /*
        
        //3⃣️添加HTTP header
        let headers = [
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        Alamofire.request(.GET, "http://httpbin.org/get", headers: headers)
            .responseJSON { response in
                debugPrint(response)
        }
        
        //使用manager,可维护session
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = ["access_token":"haha"]
        let manager = Alamofire.Manager(configuration: configuration)
        manager.request(.GET,NSURLRequest(URL: NSURL(string: url)!),parameters:parameters)
            .responseJSON{  response in
                print("haah")
        }

*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

