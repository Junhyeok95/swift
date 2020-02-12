//
//  ViewController.swift
//  SwipeGestureMission
//
//  Created by 장준혁 on 2020/02/12.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit

var images = ["01.png", "02.png", "03.png", "04.png", "05.png", "06.png"]

class ViewController: UIViewController {
    @IBOutlet var lblPage: UILabel!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        
        // 페이지 컨트롤의 색상
        pageControl.pageIndicatorTintColor = UIColor.blue
        // 선택된 페이지 색상
        pageControl.currentPageIndicatorTintColor = UIColor.red
        
        imgView.image = UIImage(named: images[0])
        lblPage.text = "page : " + String(pageControl.currentPage)
        
        // 스와이프 제스처 등록
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
    }

    @IBAction func pageChange(_ sender: UIPageControl) {
        imgView.image = UIImage(named: images[pageControl.currentPage])
        lblPage.text = "page : " + String(pageControl.currentPage)
    }
    
    // 제스쳐 오버라이드
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer { // 제스쳐가 있다면
            
            // 제스쳐에 따라서 할당
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.up:
                imgView.image = nil
                lblPage.text = nil
            case UISwipeGestureRecognizer.Direction.down:
                imgView.image = UIImage(named: images[pageControl.currentPage])
                lblPage.text = "page : " + String(pageControl.currentPage)
            case UISwipeGestureRecognizer.Direction.left:
                if imgView.image != nil && pageControl.currentPage < pageControl.numberOfPages{
                    pageControl.currentPage += 1
                    imgView.image = UIImage(named: images[pageControl.currentPage])
                    lblPage.text = "page : " + String(pageControl.currentPage)
                }
            case UISwipeGestureRecognizer.Direction.right:
                if imgView.image != nil && 0 < pageControl.currentPage {
                    pageControl.currentPage -= 1
                    imgView.image = UIImage(named: images[pageControl.currentPage])
                    lblPage.text = "page : " + String(pageControl.currentPage)
                }
            default:
                break
            }
        }
    }
    
}

