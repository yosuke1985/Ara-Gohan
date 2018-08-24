
//
//  RestaurantInfoViewController.swift
//  Ara!Gohan
//
//  Created by YOSUKE on 2018/08/23.
//  Copyright © 2018 YOSUKE. All rights reserved.
//

import UIKit

class RestaurantInfoViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navi: UINavigationItem!
    
    @IBAction func addButton(_ sender: Any) {
        print("added")
    }
    @IBOutlet weak var addButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: "MapTableViewCell", bundle: nil), forCellReuseIdentifier: "map")
        self.tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "info")


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 2

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 320.0

        case 1:
            return 350.0
        default:
            return 0.0
        }

    }
    

    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "map", for: indexPath) as! MapTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "info", for: indexPath) as! DetailTableViewCell
            return cell
            
        default:

            let cell = tableView.dequeueReusableCell(withIdentifier: "info", for: indexPath) as! DetailTableViewCell
            return cell
            
        }
        
    }

}
