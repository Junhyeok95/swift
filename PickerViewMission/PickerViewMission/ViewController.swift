//
//  ViewController.swift
//  PickerViewMission
//
//  Created by 장준혁 on 2020/01/04.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit

// 델리게이트 상속을 받아야 한다
class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let MAX_ARRAY_NUN = 10  // 배열의 크기
    let PICKER_VIEW_COLUMN = 2  // 피커 뷰의 열의 수
    let PICKER_VIEW_HEIGHT:CGFloat = 100
    var imageArray = [UIImage?]()
    var imageFileName = [ "1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg", "7.jpg", "8.jpg", "9.jpg", "10.jpg" ]
    
    @IBOutlet var pickerImage: UIPickerView!
    @IBOutlet var lblImageFileName: UILabel!
    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for i in 0 ..< MAX_ARRAY_NUN {
            // UIImage를 변수에 할당 findViewById 같은 느낌
            let image = UIImage(named: imageFileName[i])
            imageArray.append(image)
        }
        
        lblImageFileName.text = imageFileName[0]
        imageView.image = imageArray[0]
    }
    
    // 가로 수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // 피커 뷰에게 컴포넌트의 수를 정수 값으로 넘겨주는 델리게이트 메서드
        return PICKER_VIEW_COLUMN
    }
    
    // 컴포넌트 높이
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }

    // 컴포넌트 개수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // numberOfRowsInComponent 인수를 가지는 델리게이트 메서드, 피커 뷰에게 열의 개수를 정수 값으로 넘김
        // imageFileName의 개수 값인 10을 imageFileName.count를 사용하여 넘겨줌
        return imageFileName.count
    }
    
    /*
    // 글자를 리턴하고 싶을 경우
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imageFileName[row]
    }
    */
    
    // UIImageView 를 리턴
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image:imageArray[row])
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        
        return imageView
    }
    
    // 피커 뷰 선택에 따른 다른 반응 가능 !!
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component==0) {
            imageView.image = imageArray[row]
        }
        else {            
            lblImageFileName.text = imageFileName[row]
        }
    }


}

