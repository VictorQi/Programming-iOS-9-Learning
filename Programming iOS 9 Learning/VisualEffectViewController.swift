//
//  VisualEffectViewController.swift
//  Programming iOS 9 Learning
//
//  Created by Victor on 16/8/18.
//  Copyright © 2016年 VictorQi. All rights reserved.
//

import UIKit

class VisualEffectViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainview = self.view
        
        let drawing = Arrow(frame: CGRect(x: 180, y: 64, width: 200, height: 200))
        mainview.addSubview(drawing)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
