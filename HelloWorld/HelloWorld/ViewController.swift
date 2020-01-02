//
//  ViewController.swift
//  HelloWorld
//
//  Created by 장준혁 on 2020/01/02.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var lalHello: UILabel!        // 출력 아웃렛 변수
    @IBOutlet var txtName: UITextField!     // 입력 아웃렛 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnSend(_ sender: UIButton) {
        // 이벤트
        lalHello.text = "Hello, " + txtName.text!
    }
    
}
