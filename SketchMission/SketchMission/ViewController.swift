//
//  ViewController.swift
//  SketchMission
//
//  Created by 장준혁 on 2020/02/11.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var txtLineSize: UILabel!

    var lastPoint: CGPoint!
    var lineSize:CGFloat = 2.0
    var lineColor = UIColor.black.cgColor

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        txtLineSize.text = "Size : " + String(Int(lineSize))
    }

    @IBAction func clearImageView(_ sender: UIButton) {
        imgView.image = nil
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch

        lastPoint = touch.location(in: imgView)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)

        let touch = touches.first! as UITouch
        let currPoint = touch.location(in: imgView)

        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height))

        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currPoint.x, y: currPoint.y))
        UIGraphicsGetCurrentContext()?.strokePath()

        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        lastPoint = currPoint
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)

        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height))

        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.strokePath()

        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        // 흔들면 사라짐
        if motion == .motionShake {
            imgView.image = nil
        }
    }


    @IBAction func btnSizeUp(_ sender: UIButton) {
        lineSize += 1.0
        txtLineSize.text = "Size : " + String(Int(lineSize))
    }

    @IBAction func btnSizeDown(_ sender: UIButton) {
        if lineSize > 1 {
            lineSize -= 1.0
            txtLineSize.text = "Size : " + String(Int(lineSize))
        }
        else {
            let sizeAlert = UIAlertController(title: "경고 !!!", message: "더 이상 줄일 수 없습니다", preferredStyle: UIAlertController.Style.alert)
            let yesAction = UIAlertAction(title: "죄송합니다", style: UIAlertAction.Style.default, handler: nil)
            sizeAlert.addAction(yesAction)
            present(sizeAlert, animated: true, completion: nil)
        }
    }

    @IBAction func btnChangeLineColorBlack(_ sender: UIButton) {
        lineColor = UIColor.black.cgColor
    }

    @IBAction func btnChangeLineColorRed(_ sender: UIButton) {
        lineColor = UIColor.red.cgColor
    }

    @IBAction func btnChangeLineColorGreen(_ sender: UIButton) {
        lineColor = UIColor.green.cgColor
    }

    @IBAction func btnChangeLineColorBlue(_ sender: UIButton) {
        lineColor = UIColor.blue.cgColor
    }
    
}
