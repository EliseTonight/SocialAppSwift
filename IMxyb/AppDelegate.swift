//
//  AppDelegate.swift
//  IMxyb
//
//  Created by Elise on 16/4/12.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    ///leanCloud云的id与key，自填
    private let cilentId = ""
    private let cilentKey = ""

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        setWindows()
        setAppAppearance()
//        AVOSCloud.setApplicationId(cilentId, clientKey: cilentKey)
        
        
        
        // Override point for customization after application launch.
        return true
    }

    
    private func setWindows() {
        self.window = UIWindow(frame: AppSize)
        self.window?.rootViewController = MainTabViewController()
        self.window?.makeKeyAndVisible()
    }
    //设置App公共外表
    private func setAppAppearance() {
        //设置tabbarItem的外表
        let itemAppearance = UITabBarItem.appearance()
        itemAppearance.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.blackColor(),NSFontAttributeName:UIFont.systemFontOfSize(12)], forState: .Selected)
        itemAppearance.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.grayColor(), NSFontAttributeName : UIFont.systemFontOfSize(12)], forState: .Normal)
        //设置Navigation的外表
        let navigationAppearance = UINavigationBar.appearance()
        //Navigation半透明设置,半透明下也可以由数据，故会导致View的Frame错误
        
        navigationAppearance.translucent = false
        navigationAppearance.titleTextAttributes = [NSFontAttributeName:UIFont.systemFontOfSize(18),NSForegroundColorAttributeName:UIColor.blackColor()]
        //设置item
        let barItemAppearance = UIBarButtonItem.appearance()
        barItemAppearance.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFontOfSize(16),NSForegroundColorAttributeName:UIColor.blackColor()], forState: .Normal)
    }
    
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

