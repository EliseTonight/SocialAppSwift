//
//  LoadAnimationView.swift
//  LittleDay
//
//  Created by Elise on 16/3/31.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class LoadAnimationView: UIImageView {

    
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 44, height: 51))
        animationSet()
       
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var images:[UIImage]? = {
        var images:[UIImage] = []
        for i in 0...92 {
            let image = UIImage(named: String(format: "wnx%02d",i))!
            images.append(image)
        }
        return images
    }()
    
    
    private func animationSet() {
        self.animationRepeatCount = 10000
        self.animationDuration = 1.0
        self.animationImages = self.images
    }
    
    
    
    class func getLoadAnimationView() -> LoadAnimationView {
        let loadView = LoadAnimationView()
        return loadView
    }
    
    func startLoad(center:CGPoint) {
        self.center = center
        self.startAnimating()
    }
    
    func endLoad() {
        self.stopAnimating()
    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
