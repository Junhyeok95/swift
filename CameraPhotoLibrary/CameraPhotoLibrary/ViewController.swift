//
//  ViewController.swift
//  CameraPhotoLibrary
//
//  Created by 장준혁 on 2020/02/04.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit
import MobileCoreServices // 타입을 정의해 놓은 헤더 파일

// 델리게이트 프로토콜 선언
class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var imgView: UIImageView!
    
    let imagePicker: UIImagePickerController! = UIImagePickerController() // 인스턴스 변수
    var captureImage: UIImage! // 불러온 사진
    var videoURL: URL! // 녹화한 비디오의 URL
    var flagImageSave = false // 이미지 저장 여부
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // 사진 촬영 코드
    @IBAction func btnCaptureImageFromCamera(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            flagImageSave = true
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes =  [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
        else {
            // 포토 카메라
            myAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }
    
    // 사진 불러오기 코드
    @IBAction func btnLoadImageFromLibrary(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        }
        else {
            // 포토 앨범
            myAlert("Photo album inaccessable", message: "Application cannot access the photoalbum.")
        }
    }
    
    // 비디오 촬영 코드
    @IBAction func btnRecordVideoFromCamera(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            flagImageSave = true
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
        else {
            // 비디오 카메라
            myAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }
    
    // 비디오 불러오기 코드
    @IBAction func btnLoadVideoFromLibrary(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
        else {
            // 비디오 앨범
            myAlert("Photo album inaccessable", message: "Application cannot access the photoalbum.")
        }
    }
    
    // 사진아나 비디오를 촬영하거나 포토 라이브러리에서 선택이 끝났을 때 호출되는 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString // 미디어 종류를 확인
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String) { // 미디어가 사진일 경우
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage // 사진을 캡처
            
            if flagImageSave {
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil) // 캡처 값이 있으면 포토 라이브러리에 저장
            }
            
            imgView.image = captureImage
        }
        else if mediaType.isEqual(to: kUTTypeMovie as NSString as String) { // 미디어 종류가 비디오일 경우
            if flagImageSave {
                videoURL = (info[UIImagePickerController.InfoKey.mediaURL] as! URL) // 비디오 값이 있으면 포토 라이브러리에 저장
                
                UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil)
            }
        }
        
        // 현재의 뷰 제거 !!! -> 이미지 피커
        self.dismiss(animated: true, completion: nil)
    }
    
    // 사용자가 사진이나 비디오를 찍지 않고 취소하거나 선택하지 않고 최소를 하는 경우 ...
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // 현재의 뷰 제거 !!! -> 이미지 피커
        self.dismiss(animated: true, completion: nil)
        
    }
    
    // 6장 알람만들기, 경고창 만들고 추가하고 알람을 실행
    func myAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}

//        실제 앱 등록 시 권한에 대한 키를 입력해야 한다 !!!
//        실제 앱 등록 시 권한에 대한 키를 입력해야 한다 !!!
//        실제 앱 등록 시 권한에 대한 키를 입력해야 한다 !!!

        
