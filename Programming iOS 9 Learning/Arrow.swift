//
//  Arrow.swift
//  Programming iOS 9 Learning
//
//  Created by Victor on 16/8/18.
//  Copyright © 2016年 VictorQi. All rights reserved.
//

import UIKit

class Arrow: UIView {

     override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 这个很重要，因为箭头用到了透明混合模式，因此将opaque属性设置为false
        self.opaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        let con = UIGraphicsGetCurrentContext()
        
        // 绘制箭头底部的黑色部分
        CGContextMoveToPoint(con, 100, 100)
        CGContextAddLineToPoint(con, 100, 19)
        CGContextSetLineWidth(con, 20)
        CGContextStrokePath(con)
        
        // 绘制红色的箭头顶部
        CGContextSetFillColorWithColor(con, UIColor.redColor().CGColor)
        CGContextMoveToPoint(con, 80, 25)
        CGContextAddLineToPoint(con, 100, 0)
        CGContextAddLineToPoint(con, 120, 25)
        CGContextFillPath(con)
        
        // 在黑色的箭身底部剪出一个箭羽,通过在透明混合模式下绘制
        CGContextMoveToPoint(con, 90, 101)
        CGContextAddLineToPoint(con, 100, 90)
        CGContextAddLineToPoint(con, 110, 101)
        CGContextSetBlendMode(con, .Clear)
        CGContextFillPath(con)
        
    }

}
