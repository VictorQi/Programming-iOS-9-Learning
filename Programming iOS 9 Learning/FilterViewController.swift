//
//  FilterViewController.swift
//  Programming iOS 9 Learning
//
//  Created by Victor on 16/8/17.
//  Copyright © 2016年 VictorQi. All rights reserved.
//

import UIKit
import SnapKit

class FilterViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var visualView: UIView!
    
    let context = CIContext(options: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageViewDraw()
        
        self.visualViewDraw()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func visualViewDraw() {

        let v1 = UIView(frame:CGRectMake(70, 51, 132, 194))
        v1.backgroundColor = UIColor(red: 1, green: 0.4, blue: 1, alpha: 1)
        let v2 = UIView(frame:CGRectMake(41, 56, 132, 194))
        v2.backgroundColor = UIColor(red: 0.5, green: 1, blue: 0, alpha: 1)
        let v3 = UIView(frame:CGRectMake(0, 137, 160, 230))
        v3.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        visualView.addSubview(v1)
        v1.addSubview(v2)
        visualView.addSubview(v3)
        
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
 
        let vib = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blur.effect as! UIBlurEffect))
        let lab = UILabel()
        lab.text = "Hi~ Mr.Qi!"
        lab.sizeToFit()
        
        vib.contentView.addSubview(lab)
        lab.snp_makeConstraints { make in
            make.edges.equalTo(vib.contentView)
        }
        
        blur.contentView.addSubview(vib)
        vib.snp_makeConstraints { make in
            make.center.equalTo(blur.contentView)
            make.size.equalTo(CGSize(width: 150, height: 150))
        }
        
        visualView.addSubview(blur)
        blur.snp_makeConstraints { make in
            make.edges.equalTo(visualView)
        }
    }
    
    private func imageViewDraw() {
        imageView.contentMode = .Center
        
        let moi = UIImage(named: "moi")!
        let moici = CIImage(image: moi)!
        let moiExtent = moici.extent
        
        let blendImage = self.useSystemFilter(moici)
        
        let blendCGImage = self.useCustomFilter(MyVignetteFilter(), withPercentage: 0.7, toImage: moici)
        
        var which: Int { return 1 }
        switch which {
        case 1:
            let moiCG = self.context.createCGImage(blendImage, fromRect: moiExtent)
            imageView.image = UIImage(CGImage: moiCG)
            imageView.contentMode = .Center
        case 2:
            UIGraphicsBeginImageContextWithOptions(moiExtent.size, false, 0.0)
            UIImage(CIImage: blendImage).drawInRect(moiExtent)
            let moicg = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            imageView.image = moicg
        default:
            imageView.image = UIImage(CGImage: blendCGImage)
        }
    }
    
    private func useSystemFilter(moiCI: CIImage) -> CIImage {
        let moiExtent = moiCI.extent
        let center = CIVector(x: moiExtent.width/2.0, y: moiExtent.height/2.0)
        
        let smallDim = min(moiExtent.width, moiExtent.height)
        let largeDim = max(moiExtent.width, moiExtent.height)
        
        let grad = CIFilter(name: "CIRadialGradient")!
        grad.setValue(center, forKey: "inputCenter")
        grad.setValue(smallDim/2.0*0.85, forKey: "inputRadius0")
        grad.setValue(largeDim/2.0, forKey: "inputRadius1")
        let gradImage = grad.outputImage!
        
        let blendImage = moiCI.imageByApplyingFilter("CIBlendWithMask", withInputParameters: ["inputMaskImage" : gradImage])
        
        return blendImage
    }
    
    private func useCustomFilter(vig: CIFilter, withPercentage percent: CGFloat, toImage moici: CIImage) -> CGImage {
        vig.setValuesForKeysWithDictionary([
            "inputImage" : moici,
            "inputPercentage" : percent
            ])
        
        let outim = vig.outputImage!
        
        return self.context.createCGImage(outim, fromRect: outim.extent)
    }
}

class MyVignetteFilter: CIFilter {
    var inputImage: CIImage?
    var inputPercentage: NSNumber? = 1.0
    override var outputImage: CIImage? {
        return self.makeOutputImage()
    }
    
    private func makeOutputImage() -> CIImage? {
        guard let inputImage = self.inputImage else { return nil }
        guard let inputPercentage = self.inputPercentage else { return nil }
        
        let extent = inputImage.extent
        let grad = CIFilter(name: "CIRadialGradient")!
        let center = CIVector(x: extent.width/2.0, y: extent.height/2.0)
        let smallDim = min(extent.width, extent.height)/2.0
        let largeDim = max(extent.width, extent.height)/2.0
        grad.setValue(center, forKey: "inputCenter")
        grad.setValue(smallDim * CGFloat(inputPercentage), forKey: "inputRadius0")
        grad.setValue(largeDim, forKey: "inputRadius1")
        
        let blend = CIFilter(name: "CIBlendWithMask")!
        blend.setValue(inputImage, forKey: "inputImage")
        blend.setValue(grad.outputImage, forKey: "inputMaskImage")
        
        return blend.outputImage
    }
}
