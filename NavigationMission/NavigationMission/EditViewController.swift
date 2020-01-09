//
//  EditViewController.swift
//  NavigationMission
//
//  Created by 장준혁 on 2020/01/09.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit

protocol EditDelegate {
    func didMessageEditDone(_ controller: EditViewController, message:String)
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool)
    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool)
}

class EditViewController: UIViewController {
    
    var textWayValue: String = ""
    var textMassage: String = ""
    
    var isOn = false
    var isZoom = false
    
    var delegate: EditDelegate?
    
    @IBOutlet var swIsOn: UISwitch!
    @IBOutlet var btnResize: UIButton!
    
    @IBOutlet var lblWay: UILabel!
    @IBOutlet var txMessage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblWay.text = textWayValue
        txMessage.text = textMassage
        
        // 기본 전구 값
        swIsOn.isOn = isOn
        
        // 기본 줌 값
        if isZoom {
            btnResize.setTitle("전구 확대 상태", for: UIControl.State())
        } else {
            btnResize.setTitle("전구 축소 상태", for: UIControl.State())
        }
    }

    @IBAction func btnDone(_ sender: Any) {
        if delegate != nil {
            delegate?.didMessageEditDone(self, message: txMessage.text!)
            delegate?.didImageOnOffDone(self, isOn: isOn)
            delegate?.didImageZoomDone(self, isZoom: isZoom)
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func swImageOnOff(_ sender: UISwitch) {
        if sender.isOn {
            isOn = true
        } else {
            isOn = false
        }
    }
    
    @IBAction func btnResizeImage(_ sender: UIButton) {
        if isZoom {
            isZoom = false
            btnResize.setTitle("전구 축소 상태", for: UIControl.State())
        } else {
            isZoom = true
            btnResize.setTitle("전구 확대 상태", for: UIControl.State())
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
