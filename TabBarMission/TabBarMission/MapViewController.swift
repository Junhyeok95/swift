//
//  ViewController.swift
//  MapMission
//
//  Created by 장준혁 on 2020/01/06.
//  Copyright © 2020 장준혁. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
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
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        myMap.showsUserLocation = true
    }
    
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        myMap.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    // 핀을 설치하기 위해 함수를 호출
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue : CLLocationDegrees, delta span :Double, title strTitle: String, subtitle strSubtitle:String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation)
    }
    
    // 위치가 업데이트되었을 때 지도에 위치를 나타내기 위해
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.1)
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in
            let pm = placemarks!.first
            let country = pm!.country
            var address: String = country!
            if pm!.locality != nil {
                address += " "
                address += pm!.locality!
            }
            if pm!.thoroughfare != nil {
                address += " "
                address += pm!.thoroughfare!
            }
            self.lblLocationInfo1.text = "현재 위치"
            self.lblLocationInfo2.text = address
        })
        
        locationManager.stopUpdatingLocation()  // 위치가 업데이트되는 것을 멈춤
    }
    
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            locationManager.startUpdatingLocation()
        } else if sender.selectedSegmentIndex == 1 {
            setAnnotation(latitudeValue: 35.896283, longitudeValue: 128.621863, delta: 0.01, title: "영진전문대학교", subtitle: "대구광역시 북구 복현2동 복현로 35")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "영진전문대학교"
        } else if sender.selectedSegmentIndex == 2 {
            setAnnotation(latitudeValue: 33.590845, longitudeValue: 130.394681, delta: 0.05, title: "현지학기제", subtitle: "〒810-0041 福岡県福岡市中央区大名２丁目８−19 大福ビル ３F")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "ナレコミュニケーションアカデミー"
        } else if sender.selectedSegmentIndex == 3 {
            setAnnotation(latitudeValue: 35.681246, longitudeValue: 139.767069, delta: 0.05, title: "직장", subtitle: "일본 〒100-0005 Tokyo, Chiyoda City, Marunouchi, 1 Chome−9−1 JR 東日本東京駅構内 グランスタ 地下1階")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "JAPAN"
        }
    }


}

