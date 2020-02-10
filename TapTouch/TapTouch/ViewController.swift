//
//  ViewController.swift
//  TapTouch
//
//  Created by 장준혁 on 2020/02/10.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var txtMessage: UILabel!
    @IBOutlet var txtTapCount: UILabel!
    @IBOutlet var txtTouchCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { // 손가락 때면 호출
        let touch = touches.first! as UITouch
        
        txtMessage.text = "Touches Began"
        txtTapCount.text = String(touch.tapCount)
        txtTouchCount.text = String(touches.count)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) { // 손가락이 움직이면 호출
        let touch = touches.first! as UITouch
        
        txtMessage.text = "Touches Moved"
        txtTapCount.text = String(touch.tapCount)
        txtTouchCount.text = String(touches.count)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) { // 손가락을 떼었을 때 호출
        let touch = touches.first! as UITouch
        
        txtMessage.text = "Touches Ended"
        txtTapCount.text = String(touch.tapCount)
        txtTouchCount.text = String(touches.count)
    }


}

