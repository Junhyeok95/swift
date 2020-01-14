//
//  ViewController.swift
//  Audio_AVAudioPlayer
//
//  Created by 장준혁 on 2020/01/14.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit
// 재생을 위해서
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    // 오디오 재생 관련
    var audioPlayer : AVAudioPlayer!
    var audioFile : URL!
    let MAX_VOLUME : Float = 10.0
    var progressTimer : Timer!

    // 레이아웃
    @IBOutlet var pvProgressPlay: UIProgressView!
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblEndTime: UILabel!
    @IBOutlet var btnPlay: UIButton!
    @IBOutlet var btnPause: UIButton!
    @IBOutlet var btnStop: UIButton!
    @IBOutlet var slVolume: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
        
        initPlay()
    }
    
    // 오디오 재생을 위한 초기화하기 ...
    // 재생 모드와 녹음 모드를 위해서
    // 오디오 재생 초기화 과정, 녹음 초기화 과정을 분리해 놓아야 편하다
    func initPlay() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("Error-initPlay : \(error)")
        }        
    }

    @IBAction func btnPlayAudio(_ sender: UIButton) {
    }
    
    @IBAction func btnPasueAudio(_ sender: UIButton) {
    }
    
    @IBAction func btnStopAudio(_ sender: UIButton) {
    }
    
    @IBAction func slChangeVolume(_ sender: UISlider) {
    }
    
}

