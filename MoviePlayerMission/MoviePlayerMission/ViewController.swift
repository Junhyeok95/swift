//
//  ViewController.swift
//  MoviePlayerMission
//
//  Created by 장준혁 on 2020/02/03.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func btnPlayInternalMovie(_ sender: UIButton) {
        let filePath:String? = Bundle.main.path(forResource: "FastTyping", ofType: "mp4")
        let url = NSURL(fileURLWithPath: filePath!)
        
        playVideo(url: url)
    }
    @IBAction func btnPlayInternalMovie2(_ sender: UIButton) {
        let filePath:String? = Bundle.main.path(forResource: "Fireworks", ofType: "mp4")
        let url = NSURL(fileURLWithPath: filePath!)
        
        playVideo(url: url)
    }
    @IBAction func btnPlayInternalMovie3(_ sender: UIButton) {
        let filePath:String? = Bundle.main.path(forResource: "Mountaineering", ofType: "mov")
        let url = NSURL(fileURLWithPath: filePath!)
        
        playVideo(url: url)
    }
    @IBAction func btnPlayInternalMovie4(_ sender: UIButton) {
        let filePath:String? = Bundle.main.path(forResource: "Seascape", ofType: "mov")
        let url = NSURL(fileURLWithPath: filePath!)
        
        playVideo(url: url)
    }
    
    // 재생
    private func playVideo(url: NSURL)  {
        let playerController = AVPlayerViewController()
        
        let player = AVPlayer(url: url as URL)
        playerController.player = player
        
        self.present(playerController, animated: true) {
            player.play()
        }
    }
}

