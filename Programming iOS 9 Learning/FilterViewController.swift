//
//  FilterViewController.swift
//  Programming iOS 9 Learning
//
//  Created by Victor on 16/8/17.
//  Copyright © 2016年 VictorQi. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    let context = CIContext(options: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
