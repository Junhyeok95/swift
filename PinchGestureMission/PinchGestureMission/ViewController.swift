//
//  ViewController.swift
//  PinchGestureMission
//
//  Created by 장준혁 on 2020/02/12.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit

class ViewController: UIViewController, EditDelegate {

    @IBOutlet var imgView: UIImageView!
    
    var mainImgCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgView.layer.borderWidth = 2
        
    }
    
    // 세그웨이가 해당 뷰 컨트롤러로 전환되기 직전에 호출되는 함수, 데이터 전달을 위해 사용됩니다.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 데이터를 넘기는 방법
        let editViewController = segue.destination as! EditViewController
        // 바 버튼을 클릭한 경우
        if segue.identifier == "editBarButton" {
//             editViewController 내부의 변수를 컨틀롤 할 수 있다
//             ex) editViewController.text = "value"
            editViewController.imgCount = mainImgCount
            
        }
        editViewController.delegate = self
    }
    
    func didImageEditDone(_ controller: EditViewController, img: String, imgCnt: Int) {
        imgView.image = UIImage(named: img)
        mainImgCount = imgCnt
    }


}

