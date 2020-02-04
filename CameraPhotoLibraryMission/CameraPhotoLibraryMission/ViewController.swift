//
//  ViewController.swift
//  CameraPhotoLibraryMission
//
//  Created by 장준혁 on 2020/02/04.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var imgView2: UIImageView!
    @IBOutlet var imgView3: UIImageView!
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var captureImage: UIImage!
    var flagImageSave = false
    
    // 이미지 뷰를 위한 변수
    var numImage = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // 사진 저장
    @IBAction func btnCaptureImageFromCamera(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            numImage = numImage + 1
            if numImage > 3 { numImage = 1 }
            
            flagImageSave = true
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
        else {
            myAlert("카메라 접근 권한이 없습니당", message: "아직 개발하지 않았습니당")
        }
    }

    // 사진 불러오기
    @IBAction func btnLoadImageFromLibrary(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            numImage = numImage + 1
            if numImage > 3 { numImage = 1 }
            
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        }
        else {
            myAlert("포토 앨범 접근에 실패했습니당", message: "권한이 없습니당")
        }
    }
    
    // 초기화 시 코드
    @IBAction func btnClearImage(_ sender: UIButton) {
        numImage = 0
        
        imgView.image = nil
        imgView2.image = nil
        imgView3.image = nil
    }
    
    // 이미지 컨트롤러, 사진일 경우 저장, numImage 에 맞게끔
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString

        if mediaType.isEqual(to: kUTTypeImage as NSString as String) {
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage

            if flagImageSave {
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            
            if numImage == 1 { imgView.image = captureImage }
            else if numImage == 2 { imgView2.image = captureImage }
            else if numImage == 3 { imgView3.image = captureImage }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // 사용자가 취소 눌렀을 경우, 돌아가면서 버튼에 의해 늘어난 수를 감소시킴
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        numImage = numImage - 1
        if numImage < 0 { numImage = 0 } // 더 이상 내려가지 못하도록 !!
        
        // 이미지 피커 제거
        self.dismiss(animated: true, completion: nil)
    }
    
    // 경고 창 ~!
    func myAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    
}
