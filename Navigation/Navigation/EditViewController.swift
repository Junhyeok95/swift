//
//  EditViewController.swift
//  Navigation
//
//  Created by 장준혁 on 2020/01/08.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit

protocol EditDelegate {
    func didMessageEditDone(_ controller: EditViewController, message: String)
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool)
}

class EditViewController: UIViewController {
    
    var textWayValue: String = ""
    var textMessage: String = ""
    var delegate: EditDelegate?
    var isOn = false

    @IBOutlet var txMessage: UITextField!
    @IBOutlet var lblWay: UILabel!
    @IBOutlet var swIsOn: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 레이블의텍스트를 직접 제어할 수 없기 때문에 문자열 변수를 만든다.
        lblWay.text = textWayValue
        
        // 텍스트 필드의 제어를 위해서 변수를 문자열로 만든다
        txMessage.text = textMessage
        
        //스위치의 isOn 이라는 옵션에 true, false 값을 준다
        swIsOn.isOn = isOn
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        /*
        _ = navigationController?.popViewController(animated: true)
        txMessage.text = textMessage
         */
        
        // done 을 통하여 메인화면으로 데이터를 전달한다 ...
        if delegate != nil {
            // 메시지를 날려줌
            delegate?.didMessageEditDone(self, message: txMessage.text!)
            // 이미지를 날려줌
            delegate?.didImageOnOffDone(self, isOn: isOn)
            
            // example code
            // delegate?.didImageOnOffDone(EditViewController, isOn: Bool)
        }
        // 세그웨이를 show 로 호출했기 때문에 되돌아갈때는 pop 으로 .. !
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func swImageOnOff(_ sender: UISwitch) {
        if sender.isOn {
            isOn = true
        } else {
            isOn = false
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
