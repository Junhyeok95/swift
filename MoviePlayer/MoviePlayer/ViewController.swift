//
//  ViewController.swift
//  MoviePlayer
//
//  Created by 장준혁 on 2020/01/20.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit
import AVKit // 비디오 킷

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func btnPlayInternalMovie(_ sender: UIButton) {
        // 내부 파일
        let filePath:String? = Bundle.main.path(forResource: "FastTyping", ofType: "mp4") // 경로
        let url = NSURL(fileURLWithPath: filePath!) // NSURL 형식으로 변환
        
        playVideo(url: url)
    }
    @IBAction func btnPlayExternalMovie(_ sender: Any) {
        // 외부 파일
        let url = NSURL(string: "https://dl.dropboxusercontent.com/s/e38auz050w2mvud/Fireworks.mp4")!
        
        playVideo(url: url)
    }
    
    // 플레이 !!
    private func playVideo(url: NSURL) {
        // 실행
        let playerController = AVPlayerViewController() // 인스턴스
        let player = AVPlayer(url: url as URL) // URL로 인스턴스
        playerController.player = player
        self.present(playerController, animated: true) {
            player.play() // 플레이 !
        }
    }
}

