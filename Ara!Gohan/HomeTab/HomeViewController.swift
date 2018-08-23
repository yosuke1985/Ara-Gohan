//
//  FirstViewController.swift
//  Ara!Gohan
//
//  Created by YOSUKE on 2018/08/22.
//  Copyright © 2018 YOSUKE. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "MapTableViewCell", bundle: nil), forCellReuseIdentifier: "map")
        self.tableView.register(UINib(nibName: "RestaurantListTableViewCell", bundle: nil), forCellReuseIdentifier: "list")

        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    

}

