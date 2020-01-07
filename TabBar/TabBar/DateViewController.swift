//
//  ViewController.swift
//  DatePicker
//
//  Created by 장준혁 on 2020/01/03.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {
    // 타이머가 구동되면 실행할 함수
    let timeSelector: Selector = #selector(DateViewController.updateTime)
    let interval = 0.1  // 타이머의 간격 값 1초
    
    @IBOutlet var lblCurrentTime: UILabel!  // 현재시간
    @IBOutlet var lblPickerTime: UILabel!   // 선택시간
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 타이머 간격, 뷰 타겟, 실행 함수, 사용자 정보, 반복 여부
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }
    
    // 현재 시간
    @objc func updateTime() {
        let date = NSDate()
        let formatter = DateFormatter() // 포맷 형식
        formatter.dateFormat = "MM-dd HH:mm:ss EEE"
        lblCurrentTime.text = "현재시간 : " + formatter.string(from: date as Date)  // 데이터 삽입
    }
    
    @IBAction func changDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender // 선택 된 것
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd HH:mm:ss EEE"
        lblPickerTime.text = "선택시간 : " + formatter.string(from: datePickerView.date)
    }
    
}

