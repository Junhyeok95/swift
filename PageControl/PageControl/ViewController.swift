//
//  ViewController.swift
//  PageControl
//
//  Created by 장준혁 on 2020/01/06.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit

var images = ["01.png", "02.png", "03.png", "04.png", "05.png", "06.png"]

class ViewController: UIViewController {
    
    @IBOutlet var imgName: UILabel!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 페이지 컨트롤의 전체 수
        pageControl.numberOfPages = images.count
        // 현재 페이지
        pageControl.currentPage = 0
        // 페이지 컨트롤 전체 색상
        pageControl.pageIndicatorTintColor = UIColor.green
        // 내가 고른 페이지 색상
        pageControl.currentPageIndicatorTintColor = UIColor.red
        imgView.image = UIImage(named: images[0])
        
        /*
         
         스위프트 문법 - 색상을 표현하는 아법
         
         1. 커맨드 + UIColor 왼쪽 클릭 -> Jump to Deefinition 선택
         
         2. init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) 알지비 0~255, 투명도 0~1 (0 검정 , 0 투명)
         
         */
    }

    @IBAction func pageChange(_ sender: UIPageControl) {
        // 컨트롤 패널에서 선택한 번호를 이미지 뷰에 이미지를 할당
        imgView.image = UIImage(named: images[pageControl.currentPage])
        imgName.text = "現在イメージ：" + images[pageControl.currentPage]
    }
}

