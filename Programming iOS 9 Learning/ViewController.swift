//
//  ViewController.swift
//  Programming iOS 9 Learning
//
//  Created by Victor on 16/7/11.
//  Copyright © 2016年 VictorQi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var iv: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainview = view;
        
        let v1 = UIView(frame: CGRect(x: 113, y: 111, width: 132, height: 194))
        v1.backgroundColor = UIColor(red: 1, green: 0.4, blue: 1, alpha: 1)
        let v2 = UIView(frame: v1.bounds.insetBy(dx: 10, dy: 10))
        v2.backgroundColor = UIColor(red: 0.5, green: 1.0, blue: 0, alpha: 1.0)
        mainview.addSubview(v1)
        v1.addSubview(v2)
        
        v2.transform = CGAffineTransformMakeTranslation(100, 0)
        v2.transform = CGAffineTransformRotate(v2.transform, CGFloat(M_PI_4))
        v1.transform = CGAffineTransformMake(1, 0, -0.2, 1, 0, 0)
        
        
        let path = (NSBundle.mainBundle().resourcePath! as NSString).stringByAppendingPathComponent("logoRed.png")
        let image = UIImage.init(contentsOfFile: path)
        
        let v3 = UIImageView(frame: CGRect(origin: CGPoint(x: 20, y: 64), size: image!.size))
        v3.image = image
        mainview.addSubview(v3)
        
        
        let tcdisp = UITraitCollection(displayScale: UIScreen.mainScreen().scale)
        let tcphone = UITraitCollection(userInterfaceIdiom: .Phone)
        let tcreg = UITraitCollection(verticalSizeClass: .Regular)
        let tc1 = UITraitCollection(traitsFromCollections: [tcdisp, tcphone, tcreg])
        let tccom = UITraitCollection(horizontalSizeClass: .Compact)
        let tc2 = UITraitCollection(traitsFromCollections: [tcdisp, tcphone, tccom])
        let moods = UIImageAsset()
        let logo = UIImage(named: "logoRed")!
        let live = UIImage(named: "live-now")!
        moods.registerImage(logo, withTraitCollection: tc1)
        moods.registerImage(live, withTraitCollection: tc2)
        
        let mars = UIImage(named: "MarsNew")!
        let marsTiled = mars.resizableImageWithCapInsets(UIEdgeInsets(
            top: mars.size.height/2 - 1,
            left: mars.size.width/2 - 1,
            bottom: mars.size.height/2 - 1,
            right: mars.size.width/2 - 1), resizingMode: .Stretch)
        self.iv.image = marsTiled
        self.iv.contentMode = .ScaleAspectFill
        self.iv.clipsToBounds = true
        
        twoMarsDraw(at: mainview)
        
//        let drawing = Drawing(frame: CGRect(x: 180, y: 64, width: 100, height: 100))
//        mainview.addSubview(drawing)
        let drawing = ArrowWithStripes(frame: CGRect(x: 180, y: 64, width: 200, height: 200))
        mainview.addSubview(drawing)
        
        drawingIntoPicture(from: mainview)
        
        let img = drawingSplitingImage()
        let sz = img.size
        let imv = UIImageView(frame: CGRect(x: 0.0, y: 200, width: sz.width, height: sz.height))
        imv.image = img
        mainview.addSubview(imv)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func twoMarsDraw(at mainview: UIView) {
        let img = UIImage(named: "MarsNew")!
        let sz = img.size
        UIGraphicsBeginImageContextWithOptions(
            CGSize(
                width: 2*sz.width,
                height: sz.height
            ), false, 0.0)
        img.drawAtPoint(CGPoint(x: 0.0, y: 0.0))
        img.drawAtPoint(CGPoint(x: sz.width, y: 0.0))
        let im = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let imv = UIImageView(frame: CGRect(x: 0.0, y: 450, width: im.size.width, height: im.size.height))
        imv.image = im
        mainview.addSubview(imv)
    }
    
    func blendTwoMars() -> UIImage {
        let mars = UIImage(named: "MarsNew")!
        let sz = mars.size
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: 2*sz.width, height: 2*sz.height), false, 0.0)
        mars.drawInRect(CGRect(x: 0.0, y: 0.0, width: 2*sz.width, height: 2*sz.height))
        mars.drawInRect(CGRect(x: sz.width/2, y: sz.height/2, width: sz.width, height: sz.height), blendMode: .Multiply, alpha: 1.0)
        let im = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return im
    }
    
    func drawingIntoPicture(from mainview: UIView) {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 100, height: 100), false, 0)
        let con = UIGraphicsGetCurrentContext()!
        CGContextAddEllipseInRect(con, CGRect(x: 0, y: 0, width: 100, height: 100))
        CGContextSetFillColorWithColor(con, UIColor.blueColor().CGColor)
        CGContextFillPath(con)
        let im = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let imgV = UIImageView(frame: CGRect(x: 180, y: 450, width: 100, height: 100))
        imgV.image = im
        mainview.addSubview(imgV)
    }
    
    func drawingSplitingImage() -> UIImage {
        let mars = UIImage(named: "MarsNew")!
        let marsCG = mars.CGImage
        let sz = mars.size
        let szCG = CGSize(width: CGFloat(CGImageGetWidth(marsCG)), height: CGFloat(CGImageGetHeight(marsCG)))
        let marsLeft = CGImageCreateWithImageInRect(
            marsCG,
            CGRect(x: 0, y: 0, width: szCG.width/2.0, height: szCG.height))
        let marsRight = CGImageCreateWithImageInRect(
            marsCG,
            CGRect(x: szCG.width/2.0, y: 0, width: szCG.width/2.0, height: szCG.height))
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: sz.width*1.5, height: sz.height), false, 0.0)

//        let context = UIGraphicsGetCurrentContext()!
//        CGContextDrawImage(context, CGRect(x: 0.0, y: 0.0, width: sz.width/2.0, height: sz.height), marsLeft)
//        CGContextDrawImage(context, CGRect(x: sz.width, y: 0.0, width: sz.width/2.0, height: sz.height), marsRight)

//        直接使用UIImage绘制来解决flipping和scale问题
        UIImage(CGImage: marsLeft!, scale: mars.scale, orientation: mars.imageOrientation).drawAtPoint(CGPoint(x: 0.0, y: 0.0))
        UIImage(CGImage: marsRight!, scale: mars.scale, orientation: mars.imageOrientation).drawAtPoint(CGPoint(x: sz.width, y: 0.0))
        
        let im = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return im
    }
}

class MyView1: UIView {
    override func drawRect(rect: CGRect) {
        let p = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: 100, height: 100))
        UIColor.blueColor().setFill()
        p.fill()
    }
}

class MyView2: UIView {
    override func drawRect(rect: CGRect) {
        let con = UIGraphicsGetCurrentContext()
        CGContextAddEllipseInRect(con, CGRect(x: 0, y: 0, width: 100, height: 100))
        CGContextSetFillColorWithColor(con, UIColor.blueColor().CGColor)
        CGContextFillPath(con)
    }
}

class MyView3: UIView {
    override func drawRect(rect: CGRect) {}
    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        UIGraphicsPushContext(ctx)
        let p = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: 100, height: 100))
        UIColor.blueColor().setFill()
        p.fill()
        UIGraphicsPopContext()
    }
}

