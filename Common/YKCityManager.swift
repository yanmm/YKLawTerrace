//
//  YKCityManager.swift
//  YKProject
//
//  Created by Yuki on 16/9/6.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


let YKPreviousCity   =   "LastCity"

class YKCityManager: NSObject, CLLocationManagerDelegate {
    /// MARK: - 单例
    fileprivate static let instance = YKCityManager()
    class var sharedInstance: YKCityManager {
        return instance
    }
    
    /**
     获得地址
     
     :param: addressBlock    返回的位置结果
     */
    func getCity(_ addressBlock: @escaping (_ addressName: String, _ x: Double, _ y: Double) -> Void) {
        self.addressBlock = addressBlock
        startLocate()
    }
    
    /// MARK: - 成员变量
    fileprivate var manager: CLLocationManager?
    var previousAddress: String?
    
    fileprivate var addressBlock: ((_ addressName: String, _ x: Double, _ y: Double) -> Void)?
    fileprivate var errorBlock: ((_ error: NSError) -> Void)?
    
    /// MARK: - 初始化
    override init() {
        super.init()
        
        let defaults = UserDefaults.standard
        self.previousAddress = defaults.object(forKey: YKPreviousCity) as? String
    }
}

extension YKCityManager {
    /// MARK: - CLLocationManagerDelegate
    /**
     位置更新调用的代理方法
     :param: manager     调用者
     :param: newLocation 新的位置
     :param: oldLocation 以前的位置
     */
    func locationManager(_ manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        
        let defaults = UserDefaults.standard
        
        let x = newLocation.coordinate.longitude
        let y = newLocation.coordinate.latitude
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(newLocation, completionHandler: { (placemarks, error) -> Void in
            if placemarks?.count > 0 {
                let placemark = placemarks!.first
                
                var text = ""
                
                if let locality = placemark?.locality {
                    text += locality
                } else {
                    if let administrativeArea = placemark?.administrativeArea {
                        text += administrativeArea
                    }
                }
                
                if let subLocality = placemark?.subLocality {
                    text += subLocality
                }
                
                if let thoroughfare = placemark?.thoroughfare {
                    text += thoroughfare
                }

                if let subThoroughfare = placemark?.subThoroughfare {
                    text += subThoroughfare
                }
                print(placemark)
                
                self.previousAddress = text
                
                defaults.set(self.previousAddress, forKey: YKPreviousCity)
            }
            
            if let _addressBlock = self.addressBlock {
                if let _previousCity = self.previousAddress {
                    _addressBlock(_previousCity, x, y)
                    self.addressBlock = nil
                }
            }
        })
        
        manager.stopUpdatingLocation()
    }
    
    /**
     初始化定位管理器
     */
    fileprivate func startLocate() {
        if CLLocationManager.locationServicesEnabled() && CLLocationManager.authorizationStatus() != CLAuthorizationStatus.denied {
            manager = CLLocationManager()
            manager?.delegate = self
            manager?.desiredAccuracy = kCLLocationAccuracyBest
            //            manager?.requestAlwaysAuthorization()
            manager?.requestWhenInUseAuthorization()
            manager?.distanceFilter = 10
            manager?.startUpdatingLocation()
        } else {
            let delay = DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delay) {
                let alvertView = UIAlertView(title: nil, message: NSLocalizedString("alert.needToTurnLocationServices", comment: ""), delegate: nil, cancelButtonTitle: NSLocalizedString("alert.ok", comment: ""))
                alvertView.show()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.manager = nil
    }
}
