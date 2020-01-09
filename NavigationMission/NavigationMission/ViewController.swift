//
//  ViewController.swift
//  NavigationMission
//
//  Created by 장준혁 on 2020/01/09.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AddDelegate, EditDelegate{
    
    let imgOn = UIImage(named: "lamp-on.png")
    let imgOff = UIImage(named: "lamp-off.png")
    
    var isOn = true
    var isZoom = false
    var orgZoom = false
    
    var ImageAdd = false

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var txAddMessage: UITextField!
    @IBOutlet var txEditMessage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if self.ImageAdd {
            imageView.image = imgOn
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addBarButton" || segue.identifier == "addButton" {
            let addViweController = segue.destination as! AddViewController
            addViweController.textWayValue = " add segue 성공 "
            addViweController.delegate = self
            addViweController.textMassage = txAddMessage.text!
            addViweController.imageOn = self.ImageAdd
            
        } else if segue.identifier == "editBarButton" || segue.identifier == "editButton" {
            let editViweController = segue.destination as! EditViewController
            editViweController.textWayValue = " edit segue 성공 "
            editViweController.textMassage = txEditMessage.text!
            editViweController.isOn = isOn
            editViweController.isZoom = orgZoom
            editViweController.delegate = self
        }
    }
    
    func didMessageAddDone(_ controller: AddViewController, message: String) {
        txAddMessage.text = message
    }
    
    func didMessageEditDone(_ controller: EditViewController, message: String) {
        txEditMessage.text = message
    }
        
    func didImageAddDone(_ controller: AddViewController, imageOn: Bool) {
        // 전구 생성
        self.ImageAdd = isOn
        imageView.image = imgOn
    }
    
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool) {
        if self.ImageAdd { // 생성된 상태에만 ..
            if isOn {
                imageView.image = imgOn
                self.isOn = true
            } else {
                imageView.image = imgOff
                self.isOn = false
            }
        }
    }
    
    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool) {
        if self.ImageAdd { // 생성된 상태에만 ..
            let scale:CGFloat = 2.0
            var newWidth:CGFloat, newHeight:CGFloat
            
            if isZoom {
                if orgZoom {
                    
                } else {
                    self.isZoom = false
                    self.orgZoom = true
                    newWidth = imageView.frame.width*scale
                    newHeight = imageView.frame.height*scale
                    imageView.frame.size = CGSize(width: newWidth, height: newHeight)
                }
                
                print("Zoom: true")
            } else {
                if orgZoom  {
                    self.isZoom = true
                    self.orgZoom = false
                    newWidth = imageView.frame.width/scale
                    newHeight = imageView.frame.height/scale
                    imageView.frame.size = CGSize(width: newWidth, height: newHeight)
                } else {
                    
                }
                
                print("Zoom: false")
            }
        }
    }

}

