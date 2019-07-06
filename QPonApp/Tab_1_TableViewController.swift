//
//  Tab_1_TableViewController.swift
//  QPonApp
//
//  Created by K on 9/10/2018.
//  Copyright © 2018 HKBU-KYL. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class Tab_1_TableViewController: UITableViewController {
    
    var RLMresults:Results<Feed>?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(downloadJson), for: UIControl.Event.valueChanged)
        self.refreshControl = refreshControl
        
        downloadJson()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let j = RLMresults {
            return j.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "qponCell", for: indexPath)

        if let cellImage = cell.viewWithTag(101) as? UIImageView {
            
            let url = RLMresults?[indexPath.row].image
            
            if let unwrappedUrl = url {
                Alamofire.request(unwrappedUrl).responseData {
                    response in
                    
                    if let data = response.result.value {
                        cellImage.image = UIImage(data: data, scale:1)
                    }
                }
            }
            if let cellLabel = cell.viewWithTag(102) as? UILabel {
                cellLabel.text = RLMresults?[indexPath.row].title
            }
            if let cellLabel = cell.viewWithTag(103) as? UILabel {
                cellLabel.text = RLMresults?[indexPath.row].details
            }
            if let cellLabel = cell.viewWithTag(104) as? UILabel {
                
                if let value = RLMresults?[indexPath.row].coin.value {
                    cellLabel.text = "\(value)"
                }
                
                
            }
            
        }
        return cell
    }
    
    @objc func downloadJson() {
        
        let url = "https://shielded-ravine-22988.herokuapp.com/person/json"
        
        Alamofire.request(url, method: .get).validate().responseJSON {
            response in
            
            print("[Tab_1_TableViewController] Get Json Result: \(response.result)") // response serialization result
            
            switch response.result {
            case .success(let value):
                
                // print("JSON: \(value)")      // serialized json response
                
                let config = Realm.Configuration(
                    inMemoryIdentifier: "all"
                )
                
                let realm = try! Realm(configuration: config)
                let json:JSON = JSON(value)
                
                //Delete all objects from the realm
                try! realm.write {
                    realm.deleteAll()
                }
                
                for index in 0..<json.count {
                    let feed = Feed()
                    feed.title = json[index]["title"].stringValue
                    feed.restarant = json[index]["restarant"].stringValue
                    feed.coin.value = json[index]["coin"].intValue
                    feed.date = json[index]["date"].stringValue
                    feed.district = json[index]["district"].stringValue
                    feed.mall = json[index]["mall"].stringValue
                    feed.quota = json[index]["quota"].stringValue
                    feed.image = json[index]["image"].stringValue
                    feed.details = json[index]["details"].stringValue
                    feed.createdAt = json[index]["createdAt"].stringValue
                    feed.updatedAt = json[index]["updatedAt"].stringValue
                    feed._id = json[index]["id"].stringValue
                    
                    try! realm.write {
                        realm.add(feed)
                    }
                }
                
                self.RLMresults = realm.objects(Feed.self)
                
                print(self.RLMresults?.count)
                
                print("[Tab_1_TableViewController] The Qpon received: \(self.RLMresults!.count)")

                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
        
        refreshControl?.endRefreshing()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showQPon" {
            if let viewController = segue.destination as? QPon_Detail_TableViewController {
                var selectedIndex = tableView.indexPathForSelectedRow!

                if let currentQ = (RLMresults?[selectedIndex.row]) {
                    //Will be executed only when non-nil
                    viewController.c_qpon = currentQ
                }
            }
        }
    }

}
