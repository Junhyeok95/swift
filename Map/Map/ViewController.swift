//
//  ViewController.swift
//  Map
//
//  Created by 장준혁 on 2020/01/05.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var myMap: MKMapView!
    @IBOutlet var lblLocationInfo1: UILabel!
    @IBOutlet var lblLocationInfo2: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lblLocationInfo1.text = ""
        lblLocationInfo2.text = ""
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // 위치 추적 권한 요청
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확도를 최고로 설정
        locationManager.startUpdatingLocation() // 위치 업데이트를 시작
        myMap.showsUserLocation = true  // 위치 보기 값을 true ? view 를 컨트롤 !!
    }
    
    // 지도를 나타내기 위해서는 네 개의 함수를 호출
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)   // 위도 값과 경도 값을 매개변수로 사용
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span) // 범위 값을 매개변수로 사용
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)        // 위 두 값으로 pRegion 리턴
        myMap.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue : CLLocationDegrees, delta span :Double, title strTitle: String, subtitle strSubtitle:String) {
        // 핀을 설치하기 위해 함수를 호출
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation)
    }

    // 위치가 업데이트되었을 때 지도에 위치를 나타내기 위해
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 위치가 업데이트 되면 먼저 마지막 위치 값을 찾아냄
        let pLocation = locations.last
        // 마지막 위치의 위도와 경도 값을 가지고 앞에서 만든 함수를 호출 ...
        // delta 값은 지도의 크기를 정함 !! 작을수록 확대되는 효과 ... delta 0.01 는 ?? 1의 값보다 지도를 100배로 확대 !!
        goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
        // 익명함수로 처리하기 위해 {,}를 사용
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in
            let pm = placemarks!.first   // placemarks 값을 첫 부분만 pm 상수로 대입
            let country = pm!.country   // 나라 정보를 저장
            var address: String = country!  // 나라 상수 값을 저장
            if pm!.locality != nil {
                address += " "
                address += pm!.locality!    // 지역 값이 존재하면 address 문자열에 추가
            }
            if pm!.thoroughfare != nil {
                address += " "
                address += pm!.thoroughfare!    // 도로 값이 존재하면 문자열에 추가
            }
            
            self.lblLocationInfo1.text = "현재 위치"    // 클래스 변수 접근
            self.lblLocationInfo2.text = address    // 클래스 변수 접근
            
            /*
             
             self란?
             
             보통 클래스나 구조체 자신을 가리킬 때 사용한다.
             self.var 이란 클래스 내부에 선언된 변수에 접근 할 때 사용한다.
             
             nil이란?
             
             값이 존재하지 않음을 의미
             
             */
            
        })
        
        locationManager.stopUpdatingLocation()  // 위치가 업데이트되는 것을 멈춤
    }
    
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            locationManager.startUpdatingLocation()
        } else if sender.selectedSegmentIndex == 1 {
            setAnnotation(latitudeValue: 35.876159, longitudeValue: 128.595992, delta: 0.1, title: "대구역", subtitle: "대구광역시 북구 칠성동2가 302-307")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "대구역"
        } else if sender.selectedSegmentIndex == 2 {
            setAnnotation(latitudeValue: 35.896334, longitudeValue: 128.622051, delta: 0.1, title: "영진전문대학교", subtitle: "대구광역시 북구 복현2동 복현로 35")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "영진전문대학교"
        }
    }
}

