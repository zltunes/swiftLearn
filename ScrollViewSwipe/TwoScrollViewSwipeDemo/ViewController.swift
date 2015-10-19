//
//  ViewController.swift
//  TwoScrollViewSwipeDemo
//
//  Created by DuZhiXia on 15/9/14.
//  Copyright (c) 2015年 DuZhiXia. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate {
    
    ///水平滑动
    var horizontalScroll = UIScrollView()
    
    ///水平视图1,测试用,现被table1替换
    var horizontalView1 = UIView()
    
    ///水平视图2,测试用,现仍存在
    var horizontalView2 = UIView()
    
    ///水平视图3,测试用,现被table2替换
    var horizontalView3 = UIView()
    
    ///页面1按钮
    var button1 = UIButton()
    
    ///页面2按钮
    var button2 = UIButton()
    
    ///页面3按钮
    var button3 = UIButton()
    
    ///指示器视图
    var scrollIndicator = UIScrollView()
    
    ///指示器内的指示色块
    var inScrollIndicator = UIView()
    
    ///左方table
    var table1 = UITableView()
    
    ///右方table
    var table2 = UITableView()
    
    ///table1的数据源
    var data1 : NSMutableArray = ["1","2"]
    
    ///table2的数据源
    var data2 : NSMutableArray = ["1","2","3","4","5","6","7","8","9"]
    
    ///点击手势识别,用于关闭键盘
    var tapGesture = UITapGestureRecognizer()
    
    ///垂直滑动
    var verticalScroll = UIScrollView()
    
    ///垂直视图1,测试用
    var verticalView1 = UIView()
    
    ///垂直视图2,测试用
    var verticalView2 = UIView()
    
    ///总水平页面数
    let viewCountH : Int = 3
    
    ///总垂直页面数
    let viewCountV : Int = 2
    
    ///指示页面顺序的标签-水平页面1
    var label1 = UILabel()
    
    ///指示页面顺序的标签-水平页面2
    var label2 = UILabel()
    
    ///指示页面顺序的标签-水平页面3
    var label3 = UILabel()
    
    ///指示页面顺序的标签-垂直页面1
    var label4 = UILabel()
    
    ///指示页面顺序的标签-垂直页面2
    var label5 = UILabel()
    
    ///页控制器,我觉得显示了挺丑的
    var pageCtl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setUpInitialLooking()
        self.setUpActions()
        self.setUpGestures()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*********************************************/
    //每个ViewController或多或少都需要的那些东西
    /*********************************************/
    
    ///设定乱七八糟的代理监听等
    func setUpActions(){
        self.horizontalScroll.delegate = self
        self.verticalScroll.delegate = self
        self.table1.registerClass(CellOne.self, forCellReuseIdentifier: "cellOne")
        self.table2.registerClass(CellTwo.self, forCellReuseIdentifier: "cellTwo")
        self.table1.delegate = self
        self.table1.dataSource = self
        self.table2.delegate = self
        self.table2.dataSource = self
        self.button1.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
        self.button2.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
        self.button3.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
        self.pageCtl.addObserver(self, forKeyPath: "currentPage", options: .New, context: nil)
    }
    
    ///为UITableView添加点击手势识别
    func setUpGestures(){
        self.tapGesture = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.tapGesture.cancelsTouchesInView = false
        self.table2.addGestureRecognizer(self.tapGesture)
    }
    
    ///设定初始化界面
    func setUpInitialLooking(){
        let newWidth = self.view.frame.width
        let newHeight = self.view.frame.height - 100
        self.view.backgroundColor = Consts.grayView
        
        /*****************设置上方按钮*****************/
        
        self.button1.frame = CGRect(x: 0, y: 64, width: newWidth / CGFloat(self.viewCountH), height: 32)
        self.button2.frame = CGRect(x: newWidth / CGFloat(self.viewCountH), y: 64, width: newWidth / CGFloat(self.viewCountH), height: 32)
        self.button3.frame = CGRect(x: newWidth * 2 / CGFloat(self.viewCountH), y: 64, width: newWidth / 3 , height: 32)
        self.button1.backgroundColor = Consts.white
        self.button2.backgroundColor = Consts.red
        self.button3.backgroundColor = Consts.white
        self.button1.layer.cornerRadius = 5
        self.button2.layer.cornerRadius = 5
        self.button3.layer.cornerRadius = 5
        self.button1.layer.masksToBounds = true
        self.button2.layer.masksToBounds = true
        self.button3.layer.masksToBounds = true
        self.button1.setTitle("1", forState: .Normal)
        self.button2.setTitle("2", forState: .Normal)
        self.button3.setTitle("3", forState: .Normal)
        self.view.addSubview(self.button1)
        self.view.addSubview(self.button2)
        self.view.addSubview(self.button3)
        
        /*****************设置指示器*****************/
        
        self.scrollIndicator.frame = CGRect(x: 0, y: self.button1.frame.maxY + 1, width: newWidth, height: 3)
        self.inScrollIndicator.frame = CGRect(x: 0, y: 0, width: newWidth / CGFloat(self.viewCountH), height: 3)
        self.inScrollIndicator.backgroundColor = Consts.red
        self.scrollIndicator.addSubview(self.inScrollIndicator)
        self.scrollIndicator.backgroundColor = Consts.grayView
        self.view.addSubview(self.scrollIndicator)
        //1⃣️1⃣️1⃣️1⃣️1⃣️1⃣️1⃣️1⃣️1⃣️1⃣️1⃣️1⃣️1⃣️1⃣️1⃣️width问题
        self.scrollIndicator.contentSize = CGSize(width: newWidth / CGFloat(self.viewCountH) * 5, height: 0)
//        self.scrollIndicator.contentSize = CGSize(width: newWidth, height: 0)
        self.scrollIndicator.contentOffset = CGPoint(x: -newWidth / CGFloat(self.viewCountH), y: 0)
        self.scrollIndicator.pagingEnabled = true
        
        /*****************设置指示用的标签*****************/
        
        self.label1.frame = CGRect(x: newWidth / 3, y: newHeight / 3, width: newWidth / 3, height: newHeight / 3)
        self.label1.textColor = UIColor.blackColor()
        self.label2.frame = CGRect(x: newWidth / 3, y: 0, width: newWidth / 3, height: 60)
        self.label2.textColor = UIColor.blackColor()
        self.label3.frame = CGRect(x: newWidth / 3, y: newHeight / 3, width: newWidth / 3, height: newHeight / 3)
        self.label3.textColor = UIColor.blackColor()
        self.label4.frame = CGRect(x: newWidth / 3, y: newHeight / 3, width: newWidth / 3, height: newHeight / 3)
        self.label4.textColor = UIColor.blackColor()
        self.label5.frame = CGRect(x: newWidth / 3, y: newHeight / 3, width: newWidth / 3, height: newHeight / 3)
        self.label5.textColor = UIColor.blackColor()
        self.label1.textAlignment = .Center
        self.label2.textAlignment = .Center
        self.label3.textAlignment = .Center
        self.label4.textAlignment = .Center
        self.label5.textAlignment = .Center
        self.label1.text = "横向第一个"
        self.label2.text = "横向第二个"
        self.label3.text = "横向第三个"
        self.label4.text = "纵向第一个"
        self.label5.text = "纵向第二个"
        
        /*****************设置table*****************/
        
        self.table1.frame = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
        self.table2.frame = CGRect(x: newWidth * 2, y: 0, width: newWidth, height: newHeight)
        self.table1.backgroundColor = Consts.grayView
        self.table2.backgroundColor = Consts.grayView
        
        /*****************设置水平/垂直滑动*****************/
        
        self.horizontalScroll.frame = CGRect(x: 0, y: 100, width: newWidth, height: newHeight)
        self.verticalScroll.frame = CGRect(x: newWidth, y: 60, width: newWidth, height: newHeight)
        self.view.addSubview(self.horizontalScroll)
        self.horizontalScroll.addSubview(self.verticalScroll)
        
        self.horizontalView1.frame = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
        self.horizontalView1.backgroundColor = UIColor.redColor()
        self.horizontalView1.addSubview(self.label1)
        //        self.horizontalScroll.addSubview(self.horizontalView1)
        self.horizontalScroll.addSubview(self.table1)
        
        self.horizontalView2.frame = CGRect(x: newWidth, y: 0, width: newWidth, height: newHeight)
        self.horizontalView2.backgroundColor = UIColor.yellowColor()
        self.horizontalView2.addSubview(self.label2)
        self.horizontalScroll.addSubview(self.horizontalView2)
        
        self.horizontalView3.frame = CGRect(x: newWidth * CGFloat(self.viewCountV), y: 0, width: newWidth, height: newHeight)
        self.horizontalView3.backgroundColor = UIColor.blueColor()
        self.horizontalView3.addSubview(self.label3)
        //        self.horizontalScroll.addSubview(self.horizontalView3)
        self.horizontalScroll.addSubview(self.table2)
        
        self.verticalView1.frame = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
        self.verticalView1.backgroundColor = UIColor.greenColor()
        self.verticalView1.addSubview(self.label4)
        self.verticalScroll.addSubview(self.verticalView1)
        
        self.verticalView2.frame = CGRect(x: 0, y: newHeight, width: newWidth, height: newHeight)
        self.verticalView2.backgroundColor = UIColor.purpleColor()
        self.verticalView2.addSubview(self.label5)
        self.verticalScroll.addSubview(self.verticalView2)
        
        //保证垂直滑动在水平视图2的上方
        self.horizontalScroll.bringSubviewToFront(self.verticalScroll)
        
        
        /*****************设置ScrollView滑动范围*****************/
        //设置水平滑动范围
        self.horizontalScroll.contentSize = CGSize(width: newWidth * CGFloat(self.viewCountH), height: 0)
        //设置初始偏移量
        self.horizontalScroll.contentOffset = CGPoint(x: newWidth, y: 0)
        //设置垂直滑动范围
        self.verticalScroll.contentSize = CGSize(width: 0, height: newHeight * 2)
        //关闭指示器
        self.verticalScroll.showsVerticalScrollIndicator = false
        self.horizontalScroll.showsHorizontalScrollIndicator = false
        //打开翻页模式
        self.horizontalScroll.pagingEnabled = true
        
        /*****************设置页控制器*****************/
        //页面总数
        self.pageCtl.numberOfPages = self.viewCountH
        self.pageCtl.center = CGPointMake(newWidth / 2, newHeight + 20)
        self.pageCtl.bounds = CGRect(x: 0, y: 0, width: newWidth / CGFloat(self.viewCountH), height: 30)
        self.pageCtl.currentPage = 1
        
        //颜色
//        self.pageCtl.pageIndicatorTintColor = UIColor.grayColor()
//        self.pageCtl.currentPageIndicatorTintColor = UIColor.whiteColor()
        //透明，不显示
        self.pageCtl.pageIndicatorTintColor = UIColor.clearColor()
        self.pageCtl.currentPageIndicatorTintColor = UIColor.clearColor()
        
        
        //关闭控制器按钮的点击响应
        self.pageCtl.enabled = false
        
        self.view.addSubview(self.pageCtl)
        
        //保证控制器总在最前
        self.view.bringSubviewToFront(self.pageCtl)
    }
    
    /*********************************************/
    //tableView相关的数据设定
    /*********************************************/
    
    ///设定table的cell数据
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(tableView == self.table1){
            let cell = tableView.dequeueReusableCellWithIdentifier("cellOne", forIndexPath: indexPath) as! CellOne
            cell.label1.frame = CGRect(x: 20, y: 20, width: tableView.frame.width, height: 40)
            cell.label2.frame = CGRect(x: 20, y: 20 + cell.label1.frame.maxY, width: tableView.frame.width, height: 40)
            cell.label1.text = "第\(indexPath.section)行第一个"
            cell.label2.text = "第\(indexPath.section)行第二个"
            cell.addSubview(cell.label1)
            cell.addSubview(cell.label2)
            cell.backgroundColor = Consts.lightCellBkg
            cell.selectionStyle = .None
            return cell
        }else if(tableView == self.table2){
            let cell = tableView.dequeueReusableCellWithIdentifier("cellTwo", forIndexPath: indexPath) as! CellTwo
            cell.head.frame = CGRect(x: 20, y: 20, width: 80, height: 80)
            cell.head.setImage(Consts.imageFromColor(Consts.red,size: cell.head.frame.size), forState: .Normal)
            cell.head.setImage(Consts.imageFromColor(Consts.lightGray, size: cell.head.frame.size), forState: .Highlighted)
            cell.input.frame = CGRect(x: 20, y: 20 + cell.head.frame.maxY, width: tableView.frame.width, height: 60)
            cell.input.placeholder = "click here to input"
            cell.addSubview(cell.head)
            cell.addSubview(cell.input)
            cell.backgroundColor = Consts.lightCellBkg
            cell.selectionStyle = .None
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    ///设定cell高度,这里写死了
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(tableView == self.table1){
            return 20 + 40 + 20 + 40 + 20
        }else if(tableView == self.table2){
            return 20 + 80 + 20 + 60 + 20
        }else{
            return 20
        }
    }
    
    ///设定group类型下table的footerView高度
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    ///设定footerView的外形
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        footer.backgroundColor = Consts.grayView
        return footer
    }
    
    ///table每个section的cell数量
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    ///table的section数量
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if(tableView == self.table1){
            return self.data1.count
        }else if(tableView == self.table2){
            return self.data2.count
        }else{
            return 1
        }
    }
    
    /*********************************************/
    //监听和处理翻页后的变化
    /*********************************************/
    
    ///处理滑动后按钮的颜色变化
    func tabChangeTo(state : Int){
        switch (state){
        case 0:
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.25)
            UIView.setAnimationCurve(.EaseIn)
            self.button1.backgroundColor = Consts.red
            self.button2.backgroundColor = Consts.white
            self.button3.backgroundColor = Consts.white
            self.button1.backgroundColor = Consts.red
            UIView.commitAnimations()
        case 1:
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.25)
            UIView.setAnimationCurve(.EaseIn)
            self.button1.backgroundColor = Consts.white
            self.button2.backgroundColor = Consts.red
            self.button3.backgroundColor = Consts.white
            UIView.commitAnimations()
        case 2:
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.25)
            UIView.setAnimationCurve(.EaseIn)
            self.button1.backgroundColor = Consts.white
            self.button2.backgroundColor = Consts.white
            self.button3.backgroundColor = Consts.red
            UIView.commitAnimations()
        default:
            break
        }
    }
    
    ///在按钮点击后响应中实现了同样效果
    func buttonClicked(sender: UIButton){
        if(sender.titleLabel?.text == "1"){
            self.horizontalScroll.contentOffset = CGPoint(x: 0, y: 0)
        }else if(sender.titleLabel?.text == "2"){
            self.horizontalScroll.contentOffset = CGPoint(x: self.view.frame.width, y: 0)
        }else if(sender.titleLabel?.text == "3"){
            self.horizontalScroll.contentOffset = CGPoint(x: self.view.frame.width * 2, y: 0)
        }
        self.tabChangeTo(self.pageCtl.currentPage)
    }
    
    ///页面滑动后更改页控制器的当前页数
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if(scrollView == self.horizontalScroll){
            let offset : CGPoint = scrollView.contentOffset
            self.scrollIndicator.contentOffset = CGPoint(x: -offset.x / CGFloat(self.viewCountH), y: offset.y)
//            var tmpPage = Int(Float(offset.x))/Int(Float(self.horizontalScroll.frame.width))
//            let remain = Int(Float(offset.x))%Int(Float(self.horizontalScroll.frame.width))
//            //人为判断四舍五入,否则会出现左至右和右至左的切换时机不同
//            if(remain > Int(Float(self.horizontalScroll.frame.width / 2))){
//                tmpPage += 1
//            }
            let tmpPage = Int(floor((offset.x - self.view.frame.width/2)/self.view.frame.width) + 1)
            self.pageCtl.currentPage = tmpPage
        }
    }
    
    ///监听pageCtl.currentPage的变化,以改变按钮属性
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if(keyPath == "currentPage"){
            self.tabChangeTo(self.pageCtl.currentPage)
        }
    }
    
    /*********************************************/
    //各种关键盘
    /*********************************************/
    
    ///实现点击UIView内部关闭键盘
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    ///实现点击UITableView内部关闭键盘
    func dismissKeyboard(){
        let indexs : NSArray? = self.table2.indexPathsForVisibleRows
        if(indexs != nil){
            for i in indexs!{
                let v = self.table2.cellForRowAtIndexPath((i as! NSIndexPath))as? CellTwo
                if(v != nil){
                    if(v!.input.isFirstResponder()){
                        v!.input.resignFirstResponder()
                    }
                }
            }
        }
    }
    
    ///实现拖动时关闭键盘
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if(scrollView == self.table2){
            scrollView.endEditing(true)
        }
    }
    
    //    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    //        if(scrollView == self.horizontalScroll){
    //            
    //        }
    //    }
    
    
}

