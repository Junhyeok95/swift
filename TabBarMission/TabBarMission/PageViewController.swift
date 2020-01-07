//
//  ViewController.swift
//  pageControlMission
//
//  Created by 장준혁 on 2020/01/06.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {

    let PAGE_COUNT = 10
    
    @IBOutlet var lblNum: UILabel!
    @IBOutlet var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pageControl.numberOfPages = PAGE_COUNT
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        
    }

    @IBAction func pageChange(_ sender: UIPageControl) {
        lblNum.text = String(pageControl.currentPage)
    }
    
}

