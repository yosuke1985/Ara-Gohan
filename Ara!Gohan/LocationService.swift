//
//  LocationService.swift
//  Ara!Gohan
//
//  Created by YOSUKE on 2018/08/24.
//  Copyright © 2018 YOSUKE. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit


class LocationService: NSObject, CLLocationManagerDelegate{
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //CoreLocation
    public static var sharedInstance = LocationService()
    let locationManager: CLLocationManager
    var locationDataArray: [CLLocation]
    
    
    override init() {
        locationManager = CLLocationManager()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 5
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationDataArray = [CLLocation]()
        locationManager.showsBackgroundLocationIndicator = false
        
        
        super.init()
        locationManager.delegate = self
    }
    
    func startUpdatingLocation(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }else{
            //tell view controllers to show an alert
            showTurnOnLocationServiceAlert()
        }
    }
    
    
    //MARK: CLLocationManagerDelegate protocol methods
    public func locationManager(_ manager: CLLocationManager,
                                didUpdateLocations locations: [CLLocation]){
        
        if let newLocation = locations.last{
                        print("yobareta(\(newLocation.coordinate.latitude), \(newLocation.coordinate.latitude))")
            self.appDelegate.myLocation = newLocation
            
            locationDataArray.append(newLocation)
            
            notifiyDidUpdateLocation(newLocation: newLocation)
            
        }
    }
    
    
    public func locationManager(_ manager: CLLocationManager,
                                didFailWithError error: Error){
        if (error as NSError).domain == kCLErrorDomain && (error as NSError).code == CLError.Code.denied.rawValue{
            //User denied your app access to location information.
            showTurnOnLocationServiceAlert()
        }
    }
    
    public func locationManager(_ manager: CLLocationManager,
                                didChangeAuthorization status: CLAuthorizationStatus){
        if status == .authorizedWhenInUse{
            //You can resume logging by calling startUpdatingLocation here
        }
    }
    
    func showTurnOnLocationServiceAlert(){
        NotificationCenter.default.post(name: Notification.Name(rawValue:"showTurnOnLocationServiceAlert"), object: nil)
    }
    
    func notifiyDidUpdateLocation(newLocation:CLLocation){
        NotificationCenter.default.post(name: Notification.Name(rawValue:"didUpdateLocation"), object: nil, userInfo: ["location" : newLocation])
    }
    
    
}
