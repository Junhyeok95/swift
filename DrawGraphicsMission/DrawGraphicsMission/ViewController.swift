//
//  ViewController.swift
//  DrawGraphicsMission
//
//  Created by 장준혁 on 2020/02/10.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        UIGraphicsBeginImageContext(imgView.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        // Draw Circle
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.blue.cgColor)
        
        context.addEllipse(in: CGRect(x: 120, y: 150, width: 100, height: 100))
        context.addEllipse(in: CGRect(x: 120+50, y: 150, width: 100, height: 100))
        context.addEllipse(in: CGRect(x: 120-50, y: 150, width: 100, height: 100))
        context.addEllipse(in: CGRect(x: 120, y: 150-50, width: 100, height: 100))
        context.addEllipse(in: CGRect(x: 120, y: 150+50, width: 100, height: 100))
        context.strokePath()
        
        context.setStrokeColor(UIColor.red.cgColor)
        context.addEllipse(in: CGRect(x: 220, y: 450, width: 80, height: 80))
        context.strokePath()
        
        context.setStrokeColor(UIColor.blue.cgColor)
        context.addEllipse(in: CGRect(x: 220-40, y: 450-40, width: 80, height: 80))
        context.addEllipse(in: CGRect(x: 220, y: 450-40, width: 80, height: 80))
        context.addEllipse(in: CGRect(x: 220+40, y: 450-40, width: 80, height: 80))
        context.addEllipse(in: CGRect(x: 220+40, y: 450, width: 80, height: 80))
        context.strokePath()
        
        context.setStrokeColor(UIColor.green.cgColor)
        context.addEllipse(in: CGRect(x: 220+40, y: 450+40, width: 80, height: 80))
        context.addEllipse(in: CGRect(x: 220, y: 450+40, width: 80, height: 80))
        context.addEllipse(in: CGRect(x: 220-40, y: 450+40, width: 80, height: 80))
        context.addEllipse(in: CGRect(x: 220-40, y: 450, width: 80, height: 80))
        context.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }


}

