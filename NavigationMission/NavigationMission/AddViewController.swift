//
//  AddViewController.swift
//  NavigationMission
//
//  Created by 장준혁 on 2020/01/09.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit


protocol AddDelegate {
    func didMessageAddDone(_ controller: AddViewController, message:String)
    func didImageAddDone(_ controller: AddViewController, imageOn: Bool)
}

class AddViewController: UIViewController {
    
    var textWayValue: String = ""
    var textMassage: String = ""
    var delegate: AddDelegate?
    
    var imageOn = false

    @IBOutlet var txMessage: UITextField!
    @IBOutlet var lblWay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblWay.text = textWayValue
        txMessage.text = textMassage
    }
    
    @IBAction func btnDone(_ sender: Any) {
        if delegate != nil {
            delegate?.didMessageAddDone(self, message: txMessage.text!)
            delegate?.didImageAddDone(self, imageOn: imageOn)
        }
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        self.imageOn = true
        
        if delegate != nil {
            delegate?.didMessageAddDone(self, message: txMessage.text!)
            delegate?.didImageAddDone(self, imageOn: imageOn)
        }
        
        _ = navigationController?.popViewController(animated: true)
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
