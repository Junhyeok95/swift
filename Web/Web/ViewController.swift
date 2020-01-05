//
//  ViewController.swift
//  Web
//
//  Created by 장준혁 on 2020/01/05.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet var txtUrl: UITextField!
    @IBOutlet var myWebView: WKWebView!
    @IBOutlet var myActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 앱 실행 시 초기 홈페이지를 로드
        loadWebPage("http://google.com")
    }
    
    // 웹 페이지 로딩 함수 !!
    func loadWebPage(_ url:String){
        let myUrl = URL(string: url)
        let myRequest = URLRequest(url: myUrl!)
        myWebView.load(myRequest)
        
        // WebViewr가 로딩중인지 확인
        myWebView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new , context: nil)
    }
    
    // 로딩중 생기는 동그라미 !!
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
            if myWebView.isLoading {
                myActivityIndicator.startAnimating()
                myActivityIndicator.isHidden = false
            } else {
                myActivityIndicator.stopAnimating()
                myActivityIndicator.isHidden = true
            }
        }
    }
    
    /*
     
     스위프트 함수(Function) 문법 !!
     
     // 호출 방법 1
     func today(month : String, day : String) -> String {
        return "month : \(month), day : \(day)"
     }
     today(month: "1", day: "05")
     
     // 호출 방법 2  -> 호출 할 때 「파라미터 명」 없이 사용하고 싶을 경우 !!  _ 추가  !!
     func today(_ month : String, _ day : String) -> String {
        return "month : \(month), day : \(day)"
     }
     today("1", "05")
     
     */
    
    // 유알엘 체크
    func checkUrl(_ url: String) -> String {
        var strUrl = url    // 1. 입력받은 url 스틩을 임시 변수에 넣는다
        let flag = strUrl.hasPrefix("http://")  // 2. http://를 가지고 있는지 확인
        if !flag {
            strUrl = "http://" + strUrl
        }
        return strUrl
    }
    
    // 텍스트 필드에 적힌 주소로 웹 뷰가 로딩되도록 함
    @IBAction func btnGotoUrl(_ sender: UIButton) {
        // 위에서 만든 checkUrl 을 이용함
        let myUrl = checkUrl(txtUrl.text!)
        txtUrl.text = ""    // 버튼 클릭 후 입력 창 클리어
        loadWebPage(myUrl)
    }
    
    // 시트 1
    @IBAction func btnGoSite1(_ sender: UIButton) {
        loadWebPage("http://github.com")
    }
    
    // 시트 2
    @IBAction func btnGoSite2(_ sender: UIButton) {
        loadWebPage("http://github.com/junhyeok95")
    }
    
    // String 을 이용하여서 HTML 로드
    @IBAction func btnLoadHtmlString(_ sender: UIButton) {
        let htmlString = "<h1> HTML String Test</h1><p> String 변수를 이용한 웹 페이지 </p><p><a href=\"http://google.com\">구글</a>으로 이동</p>"  // html문을 변수에 저장
        myWebView.loadHTMLString(htmlString, baseURL: nil)  // 함수를 이용하여 웹 뷰에 나타냄
    }
    
    // HTML 파일을 로드
    @IBAction func btnLoadHtmlFile(_ sender: UIButton) {
        // 파일 경로 할당
        let filePath = Bundle.main.path(forResource: "htmlView", ofType: "html")
        // 패스 변수를 이용하여 URL 변수를 생성
        let myUrl = URL(fileURLWithPath: filePath!)
        let myRequest = URLRequest(url: myUrl)
        myWebView.load(myRequest)   // HTML 파일 로딩
    }
    
    // 인디케이터
    @IBAction func btnStop(_ sender: UIBarButtonItem) {
        myWebView.stopLoading() // 웹 페이지의 로딩을 중지
    }
    @IBAction func btnReload(_ sender: UIBarButtonItem) {
        myWebView.reload()  // 웹 페에지를 재로딩
    }
    @IBAction func btnGoBack(_ sender: UIBarButtonItem) {
        myWebView.goBack()  // 이전 웹 페이지로 이동
    }
    @IBAction func btnGoForward(_ sender: UIBarButtonItem) {
        myWebView.goForward()   // 다음 웹 페이지로 이동
    }
    // 인디케이터
}
