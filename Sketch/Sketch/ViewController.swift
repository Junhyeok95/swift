//
//  ViewController.swift
//  Sketch
//
//  Created by 장준혁 on 2020/02/10.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imgView: UIImageView!
    
    var lastPoint: CGPoint!
    var lineSize: CGFloat = 2.0
    var lineColor = UIColor.red.cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func clearImageView(_ sender: UIButton) {
        imgView.image = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { // 손가락 때면 호출
        let touch = touches.first! as UITouch // 현재 발생한 터치 이벤트를 가지고 옴
        
        lastPoint = touch.location(in: imgView) // 터치된 위치를 라스트 포인트에 저장 !
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) { // 손가락이 움직이면 호출
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round) // 라인의 끝 모양을 라운드 설정
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        
        let touch = touches.first! as UITouch // 터치 이벤트를 가지고 옴 !
        let currPoint = touch.location(in: imgView) // 터치된 위치를 가지고 옴 !
        
        imgView.image?.draw(in: CGRect(x:0, y:0, width: imgView.frame.size.width, height: imgView.frame.size.height)) // 현재 이미지를 그린다 ...
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y)) // 마지막 위치 포인트를 이동시킨다
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currPoint.x, y: currPoint.y)) // 현재 위치까지 선을 추가한다 ...
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        lastPoint = currPoint // 현재 터치된 위치를 할당한다
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) { // 손가락을 떼었을 때 호출
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        
        imgView.image?.draw(in: CGRect(x:0, y:0, width: imgView.frame.size.width, height: imgView.frame.size.height)) // 현재 이미지를 그린다 ...
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y)) // 마지막 위치 포인트를 이동시킨다
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y)) // 현재 위치까지 선을 추가한다 ...
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            imgView.image = nil
        }
    }
    
}

