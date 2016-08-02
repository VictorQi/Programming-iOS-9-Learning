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
        
//        let v1 = UIView(frame: CGRect(x: 113, y: 111, width: 132, height: 194))
//        v1.backgroundColor = UIColor(red: 1, green: 0.4, blue: 1, alpha: 1)
//        let v2 = UIView(frame: v1.bounds.insetBy(dx: 10, dy: 10))
//        v2.backgroundColor = UIColor(red: 0.5, green: 1.0, blue: 0, alpha: 1.0)
//        mainview.addSubview(v1)
//        v1.addSubview(v2)
//        
//        v2.transform = CGAffineTransformMakeTranslation(100, 0)
//        v2.transform = CGAffineTransformRotate(v2.transform, CGFloat(M_PI_4))
//        v1.transform = CGAffineTransformMake(1, 0, -0.2, 1, 0, 0)
//        
        
        let path = (NSBundle.mainBundle().resourcePath! as NSString).stringByAppendingPathComponent("logoRed.png")
        let image = UIImage.init(contentsOfFile: path)
        
        let v3 = UIImageView(frame: CGRect(origin: CGPoint(x: 20, y: 20), size: image!.size))
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
        
        
        let drawing = Drawing(frame: CGRect(x: 180, y: 20, width: 100, height: 100))
        mainview.addSubview(drawing)
        
        drawingIntoPicture(mainview)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawingIntoPicture(mainview: UIView) {
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
    
    func drawingIntoPicture(from mainview: UIView) {
        UIGraphicsEndImageContext()
        
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