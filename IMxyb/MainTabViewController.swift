//
//  MainTabViewController.swift
//  IMxyb
//
//  Created by Elise on 16/4/13.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setAllTabBarItem()
        self.setValue(MainTabBar(), forKey: "tabBar")
        
        // Do any additional setup after loading the view.
    }
    fileprivate func setAllTabBarItem() {
        //圈子
        setTabBar(vc: CircleViewController(), title: "圈子", imageName: "tabbar_home", imageSelectedName: "tabbar_home_selected")
        //消息
        setTabBar(vc: MessageViewController(), title: "消息", imageName: "tabbar_message_center", imageSelectedName: "tabbar_message_center_selected")
        //发现
        setTabBar(vc: DescoverViewController(), title: "通讯录", imageName: "tabbar_discover", imageSelectedName: "tabbar_discover_selected")
        //我的
        setTabBar(vc: MeViewController(), title: "我的", imageName: "tabbar_profile", imageSelectedName: "tabbar_profile_selected")
    }
    //每一个页面的初始化
    fileprivate func setTabBar(vc:UIViewController,title:String,imageName:String,imageSelectedName:String) {
        let selectImage = UIImage(named: imageSelectedName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        let normalImage = UIImage(named: imageName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        vc.tabBarItem = UITabBarItem()
        vc.tabBarItem.title = title
        vc.tabBarItem.image = normalImage
        vc.tabBarItem.selectedImage = selectImage
        vc.view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        let navigationVC = MainNavigationViewController(rootViewController:vc)
        addChildViewController(navigationVC)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
//mainTabBar的初始化
class MainTabBar:UITabBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isTranslucent = false
        self.backgroundImage = UIImage(named: "tabbar")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

