//
//  LocationManager.swift
//  MySwiftTemplate
//
//  Created by apple on 29/9/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit
//定位引用
import CoreLocation

final class LocationController : NSObject {
    static let sharedInstance = LocationController()
    
    //查找ibeacons
    func startScanBeacons(region: CLBeaconRegion) {
        locationManger.startMonitoring(for: region)
        locationManger.startRangingBeacons(in: region)
    }
    //停止查找ibeacons
    func stopScanBeacons(region: CLBeaconRegion) {
        locationManger.stopMonitoring(for: region)
        locationManger.stopRangingBeacons(in: region)
    }
    
    private override init() {
        super.init()
        
        locationManger.delegate = self
        //设置精度
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        //设置间隔距离(单位:m)内更新定位信息
        //定位要求的精度越高，distanceFilter属性的值越小，应用程序的耗电量就越大。
        locationManger.distanceFilter = 1000
        
        if(true) {
            locationManger.startUpdatingLocation()
        }
        
        //权限检查
        locationPermissionCheck()
    }
    
    func locationPermissionCheck() {
        if CLLocationManager.locationServicesEnabled() {
            print("请确认已开启定位服务")
            return
        }
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            if #available(iOS 11, *) {
                locationManger.requestAlwaysAuthorization()
            }else{
                locationManger.requestWhenInUseAuthorization()
            }
        }
    }
    
    /** 定位的当前国家 */
    var currentCountry : String? = "中国"
    
    /** 定位的当前省份 */
    var currentProvince:String?
    
    /** 定位的当前城市 */
    var currentCity:String? = "北京"
    
    /** 定位的当前城市所在的区(eg:普陀) */
    var currentArea:String?
    
    /** 定位的当前详细信息 */
    var currentAddress:String?
    
    /**
     * 定位信息
     */
    var currentLocation:CLLocation?
    
    //定位管理器
    private let locationManger = CLLocationManager()
}

extension LocationController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print("定位失败,详见: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        print("定位成功");
        
        currentLocation = locations.last
        //反地理编码
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(currentLocation!) { [unowned self] (placemarks, error) in
            //如果断网或定位失败
            guard let placemarks = placemarks else {
                return
            }
            //停止更新
            self.locationManger.stopUpdatingLocation()
            
            let placeMark : CLPlacemark? = placemarks.first
            
            //当前城市(把"市"过滤掉,否则 和 其他界面城市不匹配)
            self.currentCity = placeMark?.locality?.replacingOccurrences(of: "市", with: "")
            //详细地址
            self.currentAddress = placeMark?.subLocality
            //国家
            self.currentCountry = placeMark?.country
            //省份
            self.currentProvince = placeMark?.administrativeArea
            //区
            self.currentArea = placeMark?.subAdministrativeArea
            
            /*
             * region:                               //地理区域
             * addressDictionary:[AnyHashable : Any] //可以使用ABCreateStringWithAddressDictionary格式化为一个地址
             * thoroughfare: String?                 //街道名
             * name:String?                          //地址
             * subThoroughfare: String?              //大道
             * locality: String?                     //城市
             * subLocality: String?                  // 社区,通用名称
             * administrativeArea: String?           // state, eg. CA
             * subAdministrativeArea: String?        // 国家, eg. Santa Clara
             * postalCode: String?                   // zip code, eg. 95014
             * isoCountryCode: String?               // eg. US
             * country: String?                      // eg. United States
             * inlandWater: String?                  // 湖泊
             * ocean: String?                        // 洋
             * areasOfInterest: [String]?            // 感兴趣的地方
             */
        }
        
        //iBeacon Manager
        func locationManager(_ manager: CLLocationManager,
                             monitoringDidFailFor region: CLRegion?,
                             withError error: Error) {
            print("Failed monitoring region: \(error.localizedDescription)")
        }
        
        func locationManager(_ manager: CLLocationManager,
                             didFailWithError error: Error) {
            print("Location manager failed: \(error.localizedDescription)")
        }
        
        func locationManager(_ manager: CLLocationManager,
                             didRangeBeacons beacons: [CLBeacon],
                             in region: CLBeaconRegion) {
        }
        
        func locationManager(_ manager: CLLocationManager,
                             didEnterRegion region: CLRegion) {
            
        }
        
        func locationManager(_ manager: CLLocationManager,
                             didExitRegion region: CLRegion) {
            guard region is CLBeaconRegion else {
                return
            }
            
            //        let content = UNMutableNotificationContent()
            //        content.title = "Forget Me Not"
            //        content.body = "Are you forgetting something?"
            //        content.sound = .default()
            //
            //        let request = UNNotificationRequest(identifier: "ForgetMeNot", content: content, trigger: nil)
            //        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
}
