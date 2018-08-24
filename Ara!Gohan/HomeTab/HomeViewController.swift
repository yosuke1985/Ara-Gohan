//
//  FirstViewController.swift
//  Ara!Gohan
//
//  Created by YOSUKE on 2018/08/22.
//  Copyright © 2018 YOSUKE. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift
import GooglePlaces
import CoreLocation
import MapKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    private let manager = CLLocationManager()
    var restaurantList:[String] = []

    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "MapTableViewCell", bundle: nil), forCellReuseIdentifier: "map")
        self.tableView.register(UINib(nibName: "RestaurantListTableViewCell", bundle: nil), forCellReuseIdentifier: "list")
        self.manager.requestAlwaysAuthorization()

        update()

        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func update(){
        
        print(appDelegate.myLocation)
        
        let coordinate = CLLocationCoordinate2DMake(35.690553, 139.699579) // 現在地
        let region = MKCoordinateRegionMakeWithDistance(coordinate, 1000.0, 1000.0) // 1km * 1km
        
        //中心座標と表示範囲をマップに登録する。
        search(query: "foods", withRegion: region)
        print("restaurantList",restaurantList)

    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            
            return 320.0
        }else{
            return 100.0
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 11

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row != 0{
            performSegue(withIdentifier: "detail", sender: nil)
        }else{
            return
        }
    }

    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "map", for: indexPath) as! MapTableViewCell
            return cell
        
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath) as! RestaurantListTableViewCell
            return cell
            
            
        }

    }
    
//    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        switch indexPath.row {
//        case 0:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "map", for: indexPath) as! MapTableViewCell
//
//        default:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath) as! RestaurantListTableViewCell
//            tableView.beginUpdates()
//            print("restaurantList",restaurantList)
////            cell.textLabel?.text = restaurantList[indexPath.row-1]
//            tableView.endUpdates()
//
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detail") {
            //            let vc2: SecondViewController = (segue.destination as? SecondViewController)!
            // ViewControllerのtextVC2にメッセージを設定
            //            vc2.textVC2 = "to VC2"
        }
    }
    
    func search(query: String, withRegion region: MKCoordinateRegion?){
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = query
        
        if let region = region {
            request.region = region
        }
        
        
        MKLocalSearch(request: request).start(completionHandler: {(response, error) in
            // Error
            if error != nil {
                return
            }
            
            // Success
            guard let data = response?.mapItems, data.isEmpty == false else { return }
            
            data.forEach {
                if let name = $0.name {
                    // Name
                    self.restaurantList.append($0.name!)

                    print("name : \(name)")
                    
                    // Coordinate
                    print("coordinate : \($0.placemark.coordinate.latitude), \($0.placemark.coordinate.longitude)")
                    
                    // Address(Computed)
                    print("address : \($0.placemark.address)")
                }
            }
        } )
        

    }

}

