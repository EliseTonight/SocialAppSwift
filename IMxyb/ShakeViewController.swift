//
//  ShakeViewController.swift
//  IMxyb
//
//  Created by Elise on 16/4/21.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class ShakeViewController: UIViewController {
    @IBOutlet weak var shakeBack: UIImageView!
    @IBOutlet weak var shakeBottom: UIImageView!
    @IBOutlet weak var shakeTop: UIImageView!

    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: "ShakeViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "摇一摇"
        // Do any additional setup after loading the view.
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
