//
//  ViewController.swift
//  AudioMission
//
//  Created by 장준혁 on 2020/01/16.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit
// 재생을 위해서
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    // 오디오 재생 관련
    var audioPlayer : AVAudioPlayer!
    var audioFile : URL!
    
    // 볼륨 설정
    let MAX_VOLUME : Float = 10.0
    
    // 프로그레스
    var progressTimer : Timer!
    // 재생 타이머를 위한 상수
    let timePlayerSelector = #selector(ViewController.updatePlayTime)
    let timeRecordSelector = #selector(ViewController.updateRecordTime)

    // 레이아웃
    @IBOutlet var pvProgressPlay: UIProgressView!
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblEndTime: UILabel!
    @IBOutlet var btnPlay: UIButton!
    @IBOutlet var btnPause: UIButton!
    @IBOutlet var btnStop: UIButton!
    @IBOutlet var slVolume: UISlider!
    
    @IBOutlet var btnRecord: UIButton!
    @IBOutlet var lblRecordTime: UILabel!
    
    // 녹음을 위한 상수와 변수
    var audioRecorder : AVAudioRecorder!
    // 처음 앱을 싱행했을 때 '녹음 모드'가 아닌 '재생 모드'가 나타나게 한다
    var isRecordMode = false
    
    @IBOutlet var imgView: UIImageView!
    var imgPlay = UIImage(named: "play.png")
    var imgStop = UIImage(named: "stop.png")
    var imgRecord = UIImage(named: "record.png")
    var imgPause = UIImage(named: "pause.png")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*
        // 오디오 파일
        // audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
         */
        
        // 설정한 함수 호출
        selectAudioFile()   // 오디오 파일 선택
        if !isRecordMode {
            // 재생 모드일 때
            initPlay()  // 재생을 위한 초기화 함수 호출
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
        } else {
            // 녹음 모드일 때
            initRecord()    // 녹음을 위한 초기화 함수 호출
        }
        imgView.image = imgStop
    }
    
    // 녹음 파일과 재생 파일이 겹쳐서 저정되면 안되므로
    func selectAudioFile() {
        if !isRecordMode {
            // 재생 모드일 때
            audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
        } else {
            // 녹음 모드일 때
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            audioFile = documentDirectory.appendingPathComponent("recordFile.m4a")
        }
        
    }
    
    // 오디오 재생을 위한 초기화하기 ...
    // 재생 모드와 녹음 모드를 위해서
    // 오디오 재생 초기화 과정, 녹음 초기화 과정을 분리해 놓아야 편하다
    func initPlay() {
        do {
            // 오디오가 파일이 업을 때에 대비하여 사용
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("Error-initPlay : \(error)")
        }
        
        // 볼륨 조절
        slVolume.maximumValue = MAX_VOLUME
        slVolume.value = 1.0
        pvProgressPlay.progress = 0
        
        // 델리게이트
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.volume = slVolume.value

        // 재생 시간 초기화하기 !! -> 오디오의 총 재생 시간을 나타내기 위해서 초기화 한다
        // 형태가 초 단위의 실수 값이므로 ... "00:00" 형태로 하기위해서
        // lblEndTime.text = audioPlayer.duration 비교 해보자
        lblEndTime.text = convertNSTimeInterval2String(audioPlayer.duration)
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        
        /*
        // 재생, 일시 정지, 정지 버튼 제어하기
        btnPlay.isEnabled = true
        btnPause.isEnabled = false
        btnStop.isEnabled = false
         */
        
        // 위에 코드 대신 함수화 시켰다
        setPlayButtons(true, pause: false, stop: false)
    }
    
    // 녹음 모드의 초기화
    func initRecord() {
        let recordSetings = [
            AVFormatIDKey : NSNumber(value: kAudioFormatAppleLossless as UInt32),
            AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey : 2,
            AVSampleRateKey : 44100.0] as [String : Any]
        do {
            audioRecorder = try AVAudioRecorder(url: audioFile, settings: recordSetings)
        } catch let error as NSError {
            print("Error-initRecord : \(error)")
        }
        // delegate 를 설정하는데 상속받아야 함
        // 상단에 AVAudioRecorderDelegate 를 추가
        audioRecorder.delegate = self
        
        // 녹음 셋팅
        slVolume.value = 1.0
        audioPlayer.volume = slVolume.value
        lblEndTime.text = convertNSTimeInterval2String(0)   // 현재 재생 시간 0
        lblCurrentTime.text = convertNSTimeInterval2String(0)   // 총 재생 시간 0
        setPlayButtons(false, pause: false, stop: false)
        
        // 세션 설정 -> 왜 하는 걸까 싱글톤 ...
        let session = AVAudioSession.sharedInstance()
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            print("Error-setCategory : \(error)")
        }
        do {
            try session.setActive(true)
        } catch let error as NSError{
            print("Error-setActive : \(error)")
        }
    }
    
    // 버튼 동작 여부 설정
    func setPlayButtons(_ play:Bool, pause:Bool, stop:Bool) {
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop
    }
    
    // 시간 표기 함수
    func convertNSTimeInterval2String(_ time:TimeInterval) -> String {
        // min = 재생 시간의 매개변수인 time 을 60으로 나눈 정수 값으로
        // sec = time 값을 60으로 나눈 '나머지' 값을 정수 값으로
        let min = Int(time/60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }
    
    // -----------------------------------------------------------------------------------
    @IBAction func btnPlayAudio(_ sender: UIButton) {
        audioPlayer.play()
        setPlayButtons(false, pause: true, stop: true)
        // 셀렉터 상수를 선언하여서 0.1초 간격으로 타이머를 생성
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
        imgView.image = imgPlay
    }
    
    // 시간이 업데이트 될때마다 시간과 프로그레스를 설정
    @objc func updatePlayTime() {
        lblCurrentTime.text = convertNSTimeInterval2String(audioPlayer.currentTime)
        // currentTime = 현재 진행 시간 / duration = 지속 시간 !!
        pvProgressPlay.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
    }
    
    @IBAction func btnPasueAudio(_ sender: UIButton) {
        audioPlayer.pause()
        setPlayButtons(true, pause: false, stop: true)
        imgView.image = imgPause
    }
    
    // 멈췄을 때 시간, 오디오, 타이머 등을 설정
    @IBAction func btnStopAudio(_ sender: UIButton) {
        audioPlayer.stop()
        // 정지 될때 상황 추가
        // 표기 시간 0, 재생 시간 0
        audioPlayer.currentTime = 0
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        setPlayButtons(true, pause: false, stop: false)
        // 정지 될때 상황 추가
        // 타이머 무효화
        progressTimer.invalidate()
        imgView.image = imgStop
    }
    // -----------------------------------------------------------------------------------
    
    // 볼륨 슬라이더 값을 대입함
    @IBAction func slChangeVolume(_ sender: UISlider) {
        audioPlayer.volume = slVolume.value
    }
    
    // 재생이 끝나면 맨 처음 상태로 돌아가도록 함수를 추가
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer.invalidate()
        setPlayButtons(true, pause: false, stop: false)
        imgView.image = imgStop
    }
    
    // 스위치를 on 하면 녹음 모드가 되고 off 하면 재생 모드가 되어야 한다
    @IBAction func swRecordMode(_ sender: UISwitch) {
        // 스위치 on
        if sender.isOn {
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            // ! 차이는 ??
            lblRecordTime!.text = convertNSTimeInterval2String(0)
            isRecordMode = true
            btnRecord.isEnabled = true
            lblRecordTime.isEnabled = true
        } else {
            isRecordMode = false
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
            lblCurrentTime.text = convertNSTimeInterval2String(0)
        }
        
        // 오디오 파일을 선택하고 초기화할 함수를 호출
        selectAudioFile()
        if !isRecordMode {  // 재생 모드
            initPlay()
        } else {    // 녹음 모드
            initRecord()
        }
    }
    
    // 녹음 및 정지 제어하기 ...
    // 버튼 클릭 시 중지, 다시 클릭 시 재생 모드로 변경
    @IBAction func btnRecord(_ sender: UIButton) {
        if (sender as AnyObject).titleLabel?.text == "Record" {
            audioRecorder.record()
            (sender as AnyObject).setTitle("Stop", for: UIControl.State())
            // 녹음 시간을 표시하기 위한 타이머 설정하기
            // 녹음할 때 타이머가 작동하도록 ...
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecordSelector, userInfo: nil, repeats: true)
            imgView.image = imgRecord
        } else {
            audioPlayer.stop()
            // 녹음이 중지되면 타이머를 무효화
            progressTimer.invalidate()
            (sender as AnyObject).setTitle("Record", for: UIControl.State())
            btnPlay.isEnabled = true
            initPlay()
            imgView.image = imgStop
        }
    }
    
    // btnRecord 의 셀렉터로 이게 호출됨
    @objc func updateRecordTime() {
        lblRecordTime.text = convertNSTimeInterval2String(audioRecorder.currentTime)
    }
    
}

