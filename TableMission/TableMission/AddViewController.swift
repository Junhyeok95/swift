//
//  AddViewController.swift
//  TableMission
//
//  Created by 장준혁 on 2020/01/11.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var imageFileName = ["cart.png", "clock.png", "pencil.png"]
    let MAX_ARRAY_NUN = 3  // 배열의 크기
    let PICKER_VIEW_COLUMN = 1  // 피커 뷰의 열의 수
    let PICKER_VIEW_HEIGHT:CGFloat = 50
    var imageArray = [UIImage?]()
    
    // 전송 이미지 이름
    var imageName = ""

    @IBOutlet var tfAddItem: UITextField!
    @IBOutlet var pickerImage: UIPickerView!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        for i in 0 ..< MAX_ARRAY_NUN {
            // UIImage를 변수에 할당 findViewById 같은 느낌
            let image = UIImage(named: imageFileName[i])
            imageArray.append(image)
        }
        
        imageView.image = imageArray[0]
        // 이름 추가
        imageName = imageFileName[0]
        
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
    
    // 피커 뷰 선택에 따른 다른 반응 가능 !!
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        imageView.image = imageArray[row]
        imageName = imageFileName[row]
    }
    
    // UIImageView 를 리턴
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image:imageArray[row])
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        return imageView
    }
    
    @IBAction func btnAddItem(_ sender: UIButton) {
        items.append(tfAddItem.text!)
        itemsImageFile.append(imageName)
        tfAddItem.text=""
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
