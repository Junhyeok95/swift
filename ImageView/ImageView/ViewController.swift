//
//  ViewController.swift
//  ImageView
//
//  Created by 장준혁 on 2020/01/02.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var isZoom = false      // bool
    var imgOn: UIImage?     // ? 는 nil 값
    var imgOff: UIImage?    // 이미지 저장 변수
    
    @IBOutlet var imgView: UIImageView!     // 이미지 뷰 변수
    @IBOutlet var btnResize: UIButton!      // 확대 버튼 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgOn = UIImage(named: "lamp_on.png")       // 켠 이미지 할당
        imgOff = UIImage(named: "lamp_off.png")     // 끈 이미지 할당
        
        imgView.image = imgOn       // 켠 이미지 적용
    }

    // 확대, 축소 액션 함수
    @IBAction func btnResizeImage(_ sender: UIButton) {
        let scale: CGFloat = 2.0                    // 확대 배율
        var newWidth: CGFloat, newHeight:CGFloat    // 확대 계산 값 보관
        
        // isZoom 값을 이용해서 사이즈를 변경
        if (isZoom) {   // true
            newWidth = imgView.frame.width/scale
            newHeight = imgView.frame.height/scale
            btnResize.setTitle("확대", for: .normal)
        }
        else {  // false
            newWidth = imgView.frame.width*scale
            newHeight = imgView.frame.height*scale
            btnResize.setTitle("축소", for: .normal)
        }
        // 이미지 뷰 수정
        imgView.frame.size = CGSize(width: newWidth, height: newHeight)
        // 연산자 반전
        isZoom = !isZoom
    }
    
    // 온, 오프 스위치 엑션 함수
    @IBAction func switchImageOnOff(_ sender: UISwitch) {
        if sender.isOn {
            imgView.image = imgOn
        } else {
            imgView.image = imgOff
        }
    }
}

