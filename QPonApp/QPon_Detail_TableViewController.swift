//
//  QPon_Detail_TableViewController.swift
//  QPonApp
//
//  Created by K on 9/10/2018.
//  Copyright © 2018 HKBU-KYL. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class QPon_Detail_TableViewController: UITableViewController {
    
    var c_qpon:Feed?
    
    @IBAction func redeemBtn(_ sender: Any) {
        let alertController = UIAlertController(title: "Are you sure?" , message: "Redeem this coupon.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "No", style: .default, handler: {action in self.cancelled() }))
        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in self.redeemQponById() }))

        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func redeemQponById() {
        if let q = c_qpon {

            let url = "https://shielded-ravine-22988.herokuapp.com/user/addRedeemed?pid=\(q._id!)"

            Alamofire.request(url, method: .get).validate().responseJSON { response in

                print("[EventDetailTableViewController] Redeem Result: \(response.result)") // response serialization result

                let alertController = UIAlertController(title: "Redeemed successfully", message: "", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @objc func cancelled() {
        let alertController = UIAlertController(title: "Not enough coins or quota", message: "", preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alertController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        
        if let q = c_qpon {
            if let cellImage = cell.viewWithTag(101) as? UIImageView {

                Alamofire.request(q.image!).responseData {
                    response in
                    
                    if let data = response.result.value {
                        cellImage.image = UIImage(data: data, scale:1)
                    }
                }
            }
            
            if let cellLabel = cell.viewWithTag(102) as? UILabel {
                cellLabel.text = q.title!
            }
            if let cellLabel = cell.viewWithTag(103) as? UILabel {
                cellLabel.text = q.details!
            }
        }

        

        return cell
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
        
        if segue.identifier == "showAddress" {
            if let viewController = segue.destination as? Map_ViewController {
                if let q = c_qpon {
                    viewController.c_qpon = q
                }
            }
        }
    }

}
