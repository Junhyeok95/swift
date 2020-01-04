//
//  ViewController.swift
//  Alert
//
//  Created by 장준혁 on 2020/01/04.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 이미지 지정
    let imgOn = UIImage(named: "lamp-on.png")
    let imgOff = UIImage(named: "lamp-off.png")
    let imgRemove = UIImage(named: "lamp-remove.png")
    
    // 온 오프 변수
    var isLampOn = true
    
    @IBOutlet var lampImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // start img
        lampImg.image = imgOn
    }
       
    /*
    func myFunc (print: String) -> () {
        let name = "jang"
        let str = ("haha : \(name)")
    }
     */

    @IBAction func btnLampOn(_ sender: UIButton) {
        // 전구가 켜져 있을 경우 ... 얼럿이 나타남
        if(isLampOn == true) {
            // Controller 생성
            let lampOnAlert = UIAlertController(title: "경고", message: "이미 켜져 있습니다", preferredStyle: UIAlertController.Style.alert)
            // Action 생성
            let onAction = UIAlertAction(title: "네, 알겠습니다", style: UIAlertAction.Style.default, handler: nil)
            // 기능추가, addAction 안드로이드랑 비슷하다
            lampOnAlert.addAction(onAction)
            // present 메서드를 실행 보여주다 ?!
            present(lampOnAlert, animated: true, completion: nil)
        } else {
            lampImg.image = imgOn
            isLampOn = true
        }
    }
    
    @IBAction func btnLampOff(_ sender: UIButton) {
        if isLampOn {   // 전구가 켜져 있을 경우에만 실행
            let lampOffAlert = UIAlertController(title: "램프 끄기", message: "램프를 끄시겠습니까?", preferredStyle: UIAlertController.Style.alert)
            // handler 를 통해서 이벤트를 등록한다
            let offAction = UIAlertAction(title: "네", style: UIAlertAction.Style.default, handler:
            {
                ACTION in
                self.lampImg.image = self.imgOff    // 동작 1
                self.isLampOn = false               // 동작 2
            })
            let cancelAction = UIAlertAction(title: "아니오", style: UIAlertAction.Style.default, handler: nil)
            /*
             swift 익명함수
             
             // 형태 1
             func myFunc(value: Type) -> () {
                print("haha : \(value)")
             }
             
             // 형태 2
             {
                (value: Type) -> () in      (매개변수) -> (반환타입) in
                print("haha : \(value)")     실행구문
             }
             
             // 형태 3                        컴파일러가 반환 타입을 미리 알고 있다면 생략가능
             {
                (value: Type) in            (매개변수) in
                print("haha : \(value)")     실행구문
             }
             
             // 형태 4                        파라미터 타입이 생략된 경우 (,) 를 생략 가능
             {
                value in
                print("haha : \(value)")
             }
             
             즉 ...
             {
                 ACTION in                              func 익명함수 (ACTION 타입의 ACTION) -> (반환 생략) {
                 self.lampImg.image = self.imgOff           실행구문
                 self.isLampOn = false                  }
             }
             */
            lampOffAlert.addAction(offAction)
            lampOffAlert.addAction(cancelAction)
            present(lampOffAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnLampRemove(_ sender: UIButton) {
        let lampRemoveAlert = UIAlertController(title: "램프 제거", message: "램프를 제거하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        let offAction = UIAlertAction(title: "아니오, 끕니다(off)", style: UIAlertAction.Style.default, handler:
        {
            ACTION in
            self.lampImg.image = self.imgOff    // 동작 1 오프
            self.isLampOn = false               // 동작 2 변수 수정
        })
        let onAction = UIAlertAction(title: "아니오, 켭니다(on)", style: UIAlertAction.Style.default, handler:
        {
            ACTION in
            self.lampImg.image = self.imgOn    // 동작 1 온
            self.isLampOn = true               // 동작 2 변수 수정
        })
        let removeAction = UIAlertAction(title: "네, 제거합니다", style: UIAlertAction.Style.destructive, handler:
        {
            ACTION in
            self.lampImg.image = self.imgRemove // 동작 1 자신의 imgRemove 를 넣는다
            self.isLampOn = false               // 동작 2
        })
        lampRemoveAlert.addAction(offAction)
        lampRemoveAlert.addAction(onAction)
        lampRemoveAlert.addAction(removeAction)
        present(lampRemoveAlert, animated: true, completion: nil)
    }
}

