//
//  ViewController.swift
//  PinchGesture
//
//  Created by 장준혁 on 2020/02/12.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var txtPinch: UILabel!
    @IBOutlet var imgPinch: UIImageView!
    
    var initialFontSize:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.doPinch(_:)))
        self.view.addGestureRecognizer(pinch)
        
        let pinch2 = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.doPinch2(_:)))
        self.view.addGestureRecognizer(pinch2)
    }
    
    @objc func doPinch(_ pinch: UIPinchGestureRecognizer) {
        if (pinch.state == UIGestureRecognizer.State.began) {
            initialFontSize = txtPinch.font.pointSize
        } else {
            txtPinch.font = txtPinch.font.withSize(initialFontSize * pinch.scale)
        }
    }

    @objc func doPinch2(_ pinch2: UIPinchGestureRecognizer) {
        imgPinch.transform = imgPinch.transform.scaledBy(x: pinch2.scale, y: pinch2.scale)
        pinch2.scale = 1 // 변환을 위하여 스케일 속성을 바꾼다
    }
}

