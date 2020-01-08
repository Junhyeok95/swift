//
//  ViewController.swift
//  Navigation
//
//  Created by 장준혁 on 2020/01/08.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit

// EditDelegate 는 프로토콜이고 정보를 받기위해 상속을 받는다
// didMessageEditDone 라는 함수가 있기에 여기서 추가해준다
class ViewController: UIViewController, EditDelegate {
    
    let imgOn = UIImage(named: "lamp-on.png")
    let imgOff = UIImage(named: "lamp-off.png")
    
    var isOn = true

    @IBOutlet var txMessage: UITextField!
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgView.image = imgOn
    }
    
    // prepare 함수는 해당 세그웨이가 해당 뷰 컨트롤러로 전환되기 직전에 호출되는 함수이며 ...
    // 데이터 전달을 목적으로 사용된다
    // 세그웨이 아이디가 editButton일 경우
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 세그웨이 컨트롤러를 지정하고 그걸 활용하여서 정보를 송수신
        let editViewController = segue.destination as! EditViewController
        if segue.identifier == "editButton" {
            // 버튼을 클릭한 경우
            editViewController.textWayValue = "segue : use button"
        } else if segue.identifier == "editBarButton" {
            // 바 버튼을 클릭한 경우
            editViewController.textWayValue = "segue : use Bar button"
        }
        // 메인 -> 수정화면으로 데이터 전달
        editViewController.textMessage = txMessage.text!
        
        // 수정화면의 delegate 를 self 로 등록
        editViewController.delegate = self
        
        // 메인화면의 전구 상태를 수정화면에 반영하기
        editViewController.isOn = isOn  // 전구 상태를 펄스로 바꿈
    }
    
    // 에디트 뷰 컨트롤러에서 함수를 호출 ...
    // EditViewController 에 didMessageEditDone 을 호출한다
    func didMessageEditDone(_ controller: EditViewController, message: String) {
        // 이 메시지의 스트링 값을 텍스트 필드에 보여준다 !
        // 완료를 누르면 메인화면에 값이 들어감
        txMessage.text = message
    }
    
    // 이미지 정보 송수신 !!
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool) {
        if isOn {
            imgView.image = imgOn
            self.isOn = true
        } else {
            imgView.image = imgOff
            self.isOn = false
        }
    }
}

