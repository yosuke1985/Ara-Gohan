//
//  UserAnnotation.swift
//  Ara!Gohan
//
//  Created by YOSUKE on 2018/08/24.
//  Copyright © 2018 YOSUKE. All rights reserved.
//

import Foundation
import MapKit

class UserAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    
    convenience override init() {
        self.init(coordinate:CLLocationCoordinate2DMake(41.887, -87.622), title:"", subtitle:"")
    }
    
    required init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
    
    
    
}
