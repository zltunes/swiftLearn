//
//  customConst.swift
//  MasterTao
//
//  Created by DuZhiXia on 15/7/31.
//  Copyright (c) 2015年 Thanatos. All rights reserved.
//

import UIKit

class Consts {
    ///屏幕比例
    static let ratio : CGFloat = UIScreen.mainScreen().applicationFrame.width / 720
    
    /*********************************************/
    //字体
    /*********************************************/

    
    ///9号系统字体
    static let vSmallFont = UIFont.systemFontOfSize(9)
    
    ///10号系统字体
    static let qSmallFont = UIFont.systemFontOfSize(10)
    
    ///11号系统字体
    static let lSmallFont = UIFont.systemFontOfSize(11)
    
    ///12号系统字体
    static let smallFont = UIFont.systemFontOfSize(12)
    
    ///13号系统字体
    static let middleFont = UIFont.systemFontOfSize(13)
    
    ///14号系统字体
    static let largeFont = UIFont.systemFontOfSize(14)
    
    ///16号系统字体
    static let extraLargeFont = UIFont.systemFontOfSize(16)
    
    ///9号系统字体高度,用于计算行高
    static let vSmallHeight : CGFloat = 11.0
    
    ///10号系统字体高度,用于计算行高
    static let qSmallHeight : CGFloat = 12.0
    
    ///11号系统字体高度,用于计算行高
    static let lSmallHeight : CGFloat = 13.5
    
    ///12号系统字体高度,用于计算行高
    static let smallHeight : CGFloat = 14.0
    
    ///13号系统字体高度,用于计算行高
    static let middleHeight : CGFloat = 16.0
    
    ///14号系统字体高度,用于计算行高
    static let largeHeight : CGFloat = 17.0
    
    ///16号系统字体高度,用于计算行高
    static let extraLargeHeight : CGFloat = 19.5
    
    /*********************************************/
    //颜色
    /*********************************************/
    
    static let red = UIColor(red: 211 / 255, green: 122 / 225, blue: 107 / 225, alpha: 1)
    static let highlightedRed = UIColor(red: 211 / 255, green: 122 / 225, blue: 107 / 225, alpha: 0.5)
    static let grayView = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1)
    static let lightCellBkg = UIColor(red: 241 / 255, green: 243 / 255, blue: 245 / 255, alpha: 1)
    static let darkGray = UIColor(red: 34 / 255, green: 34 / 255, blue: 34 / 255, alpha: 1)
    static let lightGray = UIColor(red: 102 / 255, green: 102 / 255, blue: 102 / 255, alpha: 1)
    static let highlightedLightGray = UIColor(red: 102 / 255, green: 102 / 255, blue: 102 / 255, alpha: 0.5)
    static let title = UIColor.whiteColor()
    static let white = UIColor.whiteColor()
    
    /*********************************************/
    //地址
    /*********************************************/
    
    static let mainUrl = "http://api2.hloli.me:9777"
    
    /*********************************************/
    //动画相关
    /*********************************************/
    
    static let animeDuration = 0.15

    /*********************************************/
    //乱七八糟的类方法
    /*********************************************/

    ///把数据变成人民币格式,两位小数点
    class func formatNumber(str : NSString)-> String?{
        let numFormat = NSNumberFormatter()
        numFormat.numberStyle = .CurrencyStyle
        let num = NSNumber(double: str.doubleValue)
        if(numFormat.stringFromNumber(num) == nil){
            print("not a number")
        }
        var tmp : NSString = numFormat.stringFromNumber(num)!
        tmp = tmp.stringByReplacingOccurrencesOfString("$", withString: "￥")
        return tmp as String
    }
    
    ///UI偷懒用,构造一个frame紧贴文字边缘的label
    class func setUpLabel(title : String!, color : UIColor!, font : UIFont!, x : CGFloat!, y : CGFloat!)-> UILabel!{
        let label = UILabel()
        label.text = title
        label.font = font
        label.sizeToFit()
        label.textColor = color
        label.frame = CGRect(x: x, y: y, width: label.frame.width, height: label.frame.height)
        return label
    }
    
    ///UI偷懒用,构造一个frame紧贴文字边缘的label,文字支持多行
    class func setUpAttributedLabel(text : String,lineSpace : CGFloat!, color : UIColor!, font : UIFont!, x : CGFloat!, y : CGFloat!, width : CGFloat!)-> UILabel{
        let label = UILabel()
        label.frame = CGRect(x: x, y: y, width: width, height: 20)
        let paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        let attributes = [NSParagraphStyleAttributeName : paragraphStyle]
        let attributedStr = NSMutableAttributedString(string: text, attributes: attributes)
        label.numberOfLines = 0
        label.textColor = color
        label.font = font
        label.lineBreakMode = .ByWordWrapping
        label.attributedText = attributedStr
        label.sizeToFit()
        return label
    }
    
    ///将服务器端返回的Unicode编码的文字转成UTF8String
    class func unicodeStringDecode(originString: NSString)->NSString{
        let tmp1 : NSString = originString.stringByReplacingOccurrencesOfString("\\u", withString: "\\U")
        let tmp2 : NSString = tmp1.stringByReplacingOccurrencesOfString("\"", withString: "\\\"")
        let tmp3 : NSString = "\"" + (tmp2 as String) + "\""
        let tmpData : NSData = tmp3.dataUsingEncoding(NSUTF8StringEncoding)!
        let returnStr : NSString = NSPropertyListSerialization.propertyListFromData(tmpData, mutabilityOption: NSPropertyListMutabilityOptions.Immutable, format: nil, errorDescription: nil )as! NSString
        return returnStr.stringByReplacingOccurrencesOfString("\\r\\n", withString: "\n")
    }
    
    ///检查输入密码是否符合要求(仅检查位数)
    class func checkPassword(password:NSString)->Bool{
        let minLength = 6
        let maxLength = 32
        
        let cPassword : NSString = password
        var passwordOK = true
        if(cPassword.length < minLength)||(cPassword.length > maxLength){
            passwordOK = false
        }
        return passwordOK
    }
    
    ///检查手机号是否符合要求(检查是否纯数字以及位数)
    class func checkPhoneNum(phoneNum:String)->Bool{
        let phone : String = phoneNum
        var phoneOK = true
        for i in phone.characters{
            if !(i >= "0")&&(i <= "9"){
                phoneOK = false
            }
        }
        return ((phone.characters.count == 11) && phoneOK)
    }
    
    ///服务器返回的字符数组拼接(tag常用)
    class func recoverTags(tags:NSArray)->String{
        var finalTagText = ""
        for var i = 0; i <= tags.count - 1; i++ {
            finalTagText += tags.objectAtIndex(i)as! String
            if(i < tags.count - 1){
                finalTagText += " , "
            }
        }
        return finalTagText
    }
    
    ///用颜色构造UIImage
    class func imageFromColor(color: UIColor,size: CGSize)->UIImage{
//        let size = CGSizeMake(UIScreen.mainScreen().applicationFrame.width, UIScreen.mainScreen().applicationFrame.height)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        let rect = UIScreen.mainScreen().applicationFrame
        CGContextFillRect(context, rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
        
    }
    
}