//
//  Model.swift
//  Ara!Gohan
//
//  Created by YOSUKE on 2018/08/23.
//  Copyright © 2018 YOSUKE. All rights reserved.
//

//
//  Model.swift
//  DeliciousFinder
//
//  Created by YOSUKE on 2018/07/26.
//  Copyright © 2018 YOSUKE. All rights reserved.
//

import Foundation
import RealmSwift
import GooglePlaces
import CoreLocation


struct RestaurantJSON: Codable {
    let tabelog_url: String
    let name: String
    let address: String
    let pref: String
    //    let zip: Float
    let tel: String
    let latitude: Float
    let longitude:Float
    let price: String
    let category: String
    let rate: Float
    let moyori: String
    let transportation: String
    let hours: String
    let holiday: String
    let website: String
    let place_id: String
}



class Spot {
    let restaurantInfo: Restaurant
    //locationは現在地
    let location: CLLocation
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    private(set) var distance: CLLocationDistance?
    
    init (_ lat: CLLocationDegrees, _ lng: CLLocationDegrees, _ restaurant: Restaurant) {
        self.location = CLLocation(latitude: lat, longitude: lng)
        self.restaurantInfo = restaurant
    }
    
    
    //targetLocationに値を入れると、現在地との距離を出す。
    var targetLocation: CLLocation? {
        didSet {
            guard let location = targetLocation else {
                distance = nil
                return
            }
            if location.isEqual(location: oldValue) {
                return
            }
            distance = self.location.distance(from: location)
        }
    }
    
    
    static func sortedList(nearFrom location: CLLocation) -> [Spot] {
        return self.allRes.sorted(by: { spot1, spot2 in
            spot1.targetLocation = location
            spot2.targetLocation = location
            return spot1.distance! < spot2.distance!
        })
    }
    
    static var allRes: [Spot] {
        var allRes:[Spot] = []
        let queryObject = Restaurant.loadAll()
        for object in queryObject{
            let spot = Spot(object.latitude ,object.longitude ,object)
            allRes.append(spot)
        }
        return allRes
    }
    
    
}

extension CLLocation {
    // 同じ座標かどうかを返す
    func isEqual(location: CLLocation?) -> Bool {
        if let location = location {
            return self.coordinate.latitude  == location.coordinate.latitude
                && self.coordinate.longitude == location.coordinate.longitude
        }
        return false
    }
}


