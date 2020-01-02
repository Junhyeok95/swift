//
//  ViewController.swift
//  ImageViewerMission
//
//  Created by 장준혁 on 2020/01/02.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var imageName = ["01.png", "02.png", "03.png", "04.png", "05.png", "06.png"]
    var imageCnt = 0
    var imageSet: UIImage?

    @IBOutlet var imgViewer: UIImageView!
    @IBOutlet var lalTxt: UILabel!
    
    override func viewDidLoad() {   // 03 Image View 참고 작성
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageSet = UIImage(named: imageName[imageCnt])
        imgViewer.image = imageSet  // 시작 이미지 할당
    }

    // 이전 사진
    @IBAction func btnPreviousImage(_ sender: UIButton) {
        imageCnt -= 1
        if (imageCnt < 0) {
            imageCnt = 5
        }
        imgViewer.image = UIImage(named: imageName[imageCnt])
        lalTxt.text = "Image Viewer : " + String(imageCnt)
    }
    // 다음 사진
    @IBAction func btnNextImage(_ sender: UIButton) {
        imageCnt += 1
        if (imageCnt > 5) {
            imageCnt = 0
        }
        imgViewer.image = UIImage(named: imageName[imageCnt])
        lalTxt.text = "Image Viewer : " + String(imageCnt)
    }
}

