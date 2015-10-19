//
//  ViewController.swift
//  test
//
//  Created by 赵磊 on 15/10/17.
//  Copyright © 2015年 赵磊. All rights reserved.
//

/*
        工程下的.plist是不能在代码中写入的，可以读取，但是不可以写入.
        代码中进行文件写等操作只能在沙盒路径下的文件中操作。
        本工程为测试swift下的沙盒机制。
        在代码中创建、读写.plist文件。
*/

import UIKit

let HttpHeaderKey = "access_token"

class ViewController: UIViewController {
    
    var HttpHeaderValue:NSString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///创建.plist
    func createData(){

//        //沙盒的文件路径，没有此文件会自动创建
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as
        NSArray
        let documentDirectory = paths.objectAtIndex(0) as! NSString
        let filePath = documentDirectory.stringByAppendingPathComponent("to.plist")
        //要写入的dictory
        var dict:NSMutableDictionary = [HttpHeaderKey:HttpHeaderValue]
        //将dict写入token.plist
        dict.writeToFile(filePath, atomically: false)
        
        let resultDict = NSMutableDictionary(contentsOfFile: filePath)
        print("Create token.plist is --> \(resultDict?.description)")

    }
    
    
    @IBAction func save(sender: AnyObject) {
            HttpHeaderValue = "token"
            createData()
    }
    
    ///读取.plist
    func loadData(){
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("to.plist")
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        print("Loaded GameData.plist file is --> \(resultDictionary?.description)")

    }
    
}

