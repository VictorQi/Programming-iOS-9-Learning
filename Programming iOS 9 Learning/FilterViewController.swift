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
        
        let moi = UIImage(named: "moi")!
        let moiCI = CIImage(image: moi)!
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
        
        let moiCG = self.context.createCGImage(blendImage, fromRect: moiExtent)
        imageView.image = UIImage(CGImage: moiCG)
        imageView.contentMode = .Center
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
