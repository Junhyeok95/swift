//
//  ViewController.swift
//  PickerView
//
//  Created by 장준혁 on 2020/01/03.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let MAX_ARRAY_NUN = 10  // 이미지의 파일명을 저장할 배열의 최대 크기
    let PICKER_VIEW_COLUMN = 1  // 피커 뷰의 열의 수
    // 높이를 전달할 피커 뷰 델리게이트 메서드를 PICKER_VIEW_COLUMN 칼럼 밑에 추가한다
    let PICKER_VIEW_HEIGHT:CGFloat = 80
    var imageArray = [UIImage?]()
    var imageFileName = [ "1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg", "7.jpg", "8.jpg", "9.jpg", "10.jpg" ]
    
    @IBOutlet var pickerImage: UIPickerView!
    @IBOutlet var lblImageFileName: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    /*
    스위프트 for 루프 문법
     
    for i in 0...9 { print(i) } // 0부터 9까지
    for i in 0..<9 { print(i) } // 0부터 9이하
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // for in 문법 ... i 를 0부터 MAX_ARRAY_NUN 보다 작을 때까지 루프
        for i in 0 ..< MAX_ARRAY_NUN {
            // UIImage를 변수에 할당 findViewById 같은 느낌
            let image = UIImage(named: imageFileName[i])
            imageArray.append(image)
        }
        
        lblImageFileName.text = imageFileName[0]
        imageView.image = imageArray[0]
    }
    
    // 컴포넌트의 수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // 피커 뷰에게 컴포넌트의 수를 정수 값으로 넘겨주는 델리게이트 메서드
        return PICKER_VIEW_COLUMN
    }
    
    // 피커 뷰의 높이를 지정
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }

    // 열의 개수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // numberOfRowsInComponent 인수를 가지는 델리게이트 메서드, 피커 뷰에게 열의 개수를 정수 값으로 넘김
        // imageFileName의 개수 값인 10을 imageFileName.count를 사용하여 넘겨줌
        return imageFileName.count
    }
    
    /*
    // 각 열의 titleForRow 값 설정
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 각 열의 타이틀을 문자열 값으로 넘겨줌
        return imageFileName[row]
    }
    */
    
    // titleForeRow 값을 imageFileName이 아닌 UIImageView 를 리턴
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image:imageArray[row])
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        
        return imageView
    }
    
    // 피커 뷰의 룰렛에서 선택한 row 값을 사용
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
        lblImageFileName.text = imageFileName[row]
        imageView.image = imageArray[row]
    }

}

