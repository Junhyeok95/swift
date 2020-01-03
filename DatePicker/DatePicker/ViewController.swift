//
//  ViewController.swift
//  DatePicker
//
//  Created by 장준혁 on 2020/01/03.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // 타이머가 구동되면 실행할 함수
    let timeSelector: Selector = #selector(ViewController.updateTime)
    let interval = 1.0  // 타이머의 간격 값 1초
    
    // 실행 확인 임시 변수
//    var count = 0
    
    @IBOutlet var lblCurrentTime: UILabel!  // 현재시간
    @IBOutlet var lblPickerTime: UILabel!   // 선택시간
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 타이머 간격, 뷰 타겟, 실행 함수, 사용자 정보, 반복 여부
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    @IBAction func changDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        lblPickerTime.text = "선택시간 : " + formatter.string(from: datePickerView.date)
    }
    @objc func updateTime() {
        // 카운트 결과를 확인
//        lblCurrentTime.text = String(count)
//        count = count + 1
        
        // 현재 시간을 가져옴
        let date = NSDate()
        
        // 출력하기 위한 클래스의 상수
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        lblCurrentTime.text = "현재시간 : " + formatter.string(from: date as Date)
    }
}

