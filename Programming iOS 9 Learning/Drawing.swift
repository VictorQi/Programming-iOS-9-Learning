//
//  Drawing.swift
//  Programming iOS 9 Learning
//
//  Created by Victor on 16/8/1.
//  Copyright © 2016年 VictorQi. All rights reserved.
//

import UIKit

class Drawing: UIView {
  
    override func drawRect(rect: CGRect) {}
    
    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        CGContextAddEllipseInRect(ctx, CGRect(x: 0, y: 0, width: 100, height: 100))
        CGContextSetFillColorWithColor(ctx, UIColor.blueColor().CGColor)
        CGContextFillPath(ctx)
    }

}
