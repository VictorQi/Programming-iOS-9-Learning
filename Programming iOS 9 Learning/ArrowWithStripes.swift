//
//  ArrowWithStripes.swift
//  Programming iOS 9 Learning
//
//  Created by v.q on 16/8/21.
//  Copyright © 2016年 VictorQi. All rights reserved.
//

import UIKit

class ArrowWithStripes: UIView {
    
    let which = 2
    lazy var arrow: UIImage = self.arrowImage()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.opaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        switch which {
        case 1:
            let con = UIGraphicsGetCurrentContext()!
            self.arrow.drawAtPoint(CGPointMake(0,0))
            for _ in 0..<3 {
                CGContextTranslateCTM(con, 20, 100)
                CGContextRotateCTM(con, 30 * CGFloat(M_PI)/180.0)
                CGContextTranslateCTM(con, -20, -100)
                self.arrow.drawAtPoint(CGPointMake(0,0))
            }
            
        case 2:
            let con = UIGraphicsGetCurrentContext()!
            CGContextSetShadow(con, CGSizeMake(7, 7), 12)
            
            self.arrow.drawAtPoint(CGPointMake(0,0))
            for _ in 0..<3 {
                CGContextTranslateCTM(con, 20, 100)
                CGContextRotateCTM(con, 30 * CGFloat(M_PI)/180.0)
                CGContextTranslateCTM(con, -20, -100)
                self.arrow.drawAtPoint(CGPointMake(0,0))
            }
            
        case 3:
            let con = UIGraphicsGetCurrentContext()!
            CGContextSetShadow(con, CGSizeMake(7, 7), 12)
            
            CGContextBeginTransparencyLayer(con, nil)
            self.arrow.drawAtPoint(CGPointMake(0,0))
            for _ in 0..<3 {
                CGContextTranslateCTM(con, 20, 100)
                CGContextRotateCTM(con, 30 * CGFloat(M_PI)/180.0)
                CGContextTranslateCTM(con, -20, -100)
                self.arrow.drawAtPoint(CGPointMake(0,0))
            }
            CGContextEndTransparencyLayer(con)
            
        default: break
        }
    }
    
    private func arrowImage() -> UIImage {
       
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 40, height: 100), false, 0.0)
        
        let con = UIGraphicsGetCurrentContext()!
        CGContextSaveGState(con)
        
        CGContextMoveToPoint(con, 10, 100)
        CGContextAddLineToPoint(con, 20, 90)
        CGContextAddLineToPoint(con, 30, 100)
        CGContextClosePath(con)
        CGContextAddRect(con, CGContextGetClipBoundingBox(con))
        CGContextEOClip(con)
        
        CGContextMoveToPoint(con, 20, 100)
        CGContextAddLineToPoint(con, 20, 19)
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
        CGContextDrawLinearGradient(con, grad, CGPoint(x: 9, y: 0), CGPoint(x: 31, y: 0), [])
        
        CGContextRestoreGState(con)
        
        // 不用纯色来进行绘制，用模式图片块
        // CGContextSetFillColorWithColor(con, UIColor.redColor().CGColor)
//        UIGraphicsBeginImageContextWithOptions(CGSize(width: 4, height: 4), false, 0.0)
//        let imcon = UIGraphicsGetCurrentContext()!
//        CGContextSetFillColorWithColor(imcon, UIColor.redColor().CGColor)
//        CGContextFillRect(imcon, CGRect(x: 0, y: 0, width: 4, height: 4))
//        CGContextSetFillColorWithColor(imcon, UIColor.blueColor().CGColor)
//        CGContextFillRect(imcon, CGRect(x: 0, y: 0, width: 4, height: 2))
//        let stripes = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        let stripePattern = UIColor(patternImage: stripes)
//        stripePattern.setFill()
//        let p = UIBezierPath()
//        p.moveToPoint(CGPoint(x: 0, y: 25))
//        p.addLineToPoint(CGPoint(x: 20, y: 0))
//        p.addLineToPoint(CGPoint(x: 40, y: 25))
//        p.fill()
        
        
        // 使用Core Graphics的CGPattern
        let sp2 = CGColorSpaceCreatePattern(nil)
        CGContextSetFillColorSpace(con, sp2)
        let drawStripes: CGPatternDrawPatternCallback = {
            _, con in
            CGContextSetFillColorWithColor(con!, UIColor.redColor().CGColor)
            CGContextFillRect(con!, CGRect(x: 0, y: 0, width: 4, height: 4))
            CGContextSetFillColorWithColor(con!, UIColor.blueColor().CGColor)
            CGContextFillRect(con!, CGRect(x: 0, y: 0, width: 4, height: 2))
        }
        var callbacks = CGPatternCallbacks(version: 0, drawPattern: drawStripes, releaseInfo: nil)
        let patt = CGPatternCreate(nil, CGRect(x: 0, y: 0, width: 4, height: 4), CGAffineTransformIdentity, 4, 4, .ConstantSpacingMinimalDistortion, true, &callbacks)
        var alph: CGFloat = 1.0
        CGContextSetFillPattern(con, patt, &alph)
        CGContextMoveToPoint(con, 0, 25)
        CGContextAddLineToPoint(con, 20, 0)
        CGContextAddLineToPoint(con, 40, 25)
        CGContextFillPath(con)
        
        let im = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return im
    }

    
}
