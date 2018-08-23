//
//  SecondViewController.swift
//  Ara!Gohan
//
//  Created by YOSUKE on 2018/08/22.
//  Copyright © 2018 YOSUKE. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: "RestaurantListTableViewCell", bundle: nil), forCellReuseIdentifier: "list")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 10
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath) as! RestaurantListTableViewCell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "detail", sender: nil)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detail") {
            //            let vc2: SecondViewController = (segue.destination as? SecondViewController)!
            // ViewControllerのtextVC2にメッセージを設定
            //            vc2.textVC2 = "to VC2"
        }
    }
    
    
    @IBAction func editAction(_ sender: Any) {
        print("edit")
    }
    
}

