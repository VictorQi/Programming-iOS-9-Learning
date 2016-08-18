//
//  ArrowWithEOClip.swift
//  Programming iOS 9 Learning
//
//  Created by v.q on 16/8/18.
//  Copyright © 2016年 VictorQi. All rights reserved.
//

import UIKit

class ArrowWithEOClip: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.opaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        let con = UIGraphicsGetCurrentContext()
        
        CGContextMoveToPoint(con, 90, 100)
        CGContextAddLineToPoint(con, 100, 90)
        CGContextAddLineToPoint(con, 110, 100)
        CGContextClosePath(con)
        
        let outTriangle = CGContextGetClipBoundingBox(con)
        CGContextAddRect(con, outTriangle)
        CGContextEOClip(con)
        
        CGContextMoveToPoint(con, 100, 100)
        CGContextAddLineToPoint(con, 100, 19)
        CGContextSetLineWidth(con, 20)
        CGContextStrokePath(con)
        
        CGContextSetFillColorWithColor(con, UIColor.redColor().CGColor)
        CGContextMoveToPoint(con, 80, 25)
        CGContextAddLineToPoint(con, 100, 0)
        CGContextAddLineToPoint(con, 120, 25)
        CGContextFillPath(con)
    }

}
