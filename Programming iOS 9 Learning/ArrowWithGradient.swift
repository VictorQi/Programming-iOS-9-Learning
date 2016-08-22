//
//  ArrowWithGradient.swift
//  Programming iOS 9 Learning
//
//  Created by v.q on 16/8/20.
//  Copyright © 2016年 VictorQi. All rights reserved.
//

import UIKit

class ArrowWithGradient: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.opaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        // 获得当前的上下文
        let con = UIGraphicsGetCurrentContext()!
        CGContextSaveGState(con)
        // 在上下文剪裁区域中加入三角形的洞
        CGContextMoveToPoint(con, 90, 100)
        CGContextAddLineToPoint(con, 100, 90)
        CGContextAddLineToPoint(con, 110, 100)
        CGContextClosePath(con)
        CGContextAddRect(con, CGContextGetClipBoundingBox(con))
        CGContextEOClip(con)
        // 绘制竖直的箭头粗线，将它加入到裁剪区域中
        CGContextMoveToPoint(con, 100, 100)
        CGContextAddLineToPoint(con, 100, 19)
        CGContextSetLineWidth(con, 20)
        CGContextReplacePathWithStrokedPath(con)
        CGContextClip(con)
        // 绘制渐变色
        let locs: [CGFloat] = [0.0, 0.5, 1.0]
        let colors: [CGFloat] = [
            0.8, 0.4, //初始色彩，透明的浅灰色
            0.1, 0.5, // 中间色彩，比透明的灰色更黑一点
            0.8, 0.4, // 结束色彩，依旧是透明的浅灰
        ]
        let sp = CGColorSpaceCreateDeviceGray()
        let grad = CGGradientCreateWithColorComponents(sp, colors, locs, 3)
        CGContextDrawLinearGradient(con, grad, CGPoint(x: 89, y: 0), CGPoint(x: 111, y: 0), [])
        // 完成裁剪
        CGContextRestoreGState(con)
        CGContextSetFillColorWithColor(con, UIColor.redColor().CGColor)
        CGContextMoveToPoint(con, 80, 25)
        CGContextAddLineToPoint(con, 100, 0)
        CGContextAddLineToPoint(con, 120, 25)
        CGContextFillPath(con)
    }

}
