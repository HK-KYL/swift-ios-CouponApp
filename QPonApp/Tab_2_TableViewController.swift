//
//  Tab_2_TableViewController.swift
//  QPonApp
//
//  Created by K on 10/10/2018.
//  Copyright © 2018 HKBU-KYL. All rights reserved.
//

import UIKit
import RealmSwift

class Tab_2_TableViewController: UITableViewController {
    
    var RLM_Malls_HK_Island:Results<malls>?
    var RLM_Malls_Kowloon:Results<malls>?
    var RLM_Malls_New_Territories:Results<malls>?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let config = Realm.Configuration(
            fileURL: Bundle.main.url(forResource: "MallsInfo", withExtension: "realm"),
            readOnly: true
        )
        
        let realm = try! Realm(configuration: config)
        
        RLM_Malls_HK_Island = realm.objects(malls.self).filter("District == 'HK Island'")
        RLM_Malls_Kowloon = realm.objects(malls.self).filter("District == 'Kowloon'")
        RLM_Malls_New_Territories = realm.objects(malls.self).filter("District == 'New Territories'")
        
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        if section == 0 {
            if let c = RLM_Malls_HK_Island?.count {
                return c
            }
        } else if section == 1 {
            if let c = RLM_Malls_Kowloon?.count {
                return c
            }
        } else if section == 2 {
            if let c = RLM_Malls_New_Territories?.count {
                return c
            }
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "areaCell", for: indexPath)

        // Configure the cell...
        
        if indexPath.section == 0 {
            cell.textLabel?.text = RLM_Malls_HK_Island?[indexPath.row].Mall
        } else if indexPath.section == 1 {
            cell.textLabel?.text = RLM_Malls_Kowloon?[indexPath.row].Mall
        } else if indexPath.section == 2 {
            cell.textLabel?.text = RLM_Malls_New_Territories?[indexPath.row].Mall
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "HK Island"
        } else if section == 1 {
            return "Kowloon"
        } else if section == 2 {
            return "New Territories"
        }
        return "Other"
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
        if segue.identifier == "showQPonByMall" {
            if let viewController = segue.destination as? List_TableViewController {
                var selectedIndex = tableView.indexPathForSelectedRow!

                var source:Results<malls>?
                
                if selectedIndex.section == 0 {
                    source = RLM_Malls_HK_Island
                } else if selectedIndex.section == 1 {
                    source = RLM_Malls_Kowloon
                } else if selectedIndex.section == 2 {
                    source = RLM_Malls_New_Territories
                }
                
                if let c_mall = source?[selectedIndex.row] {
                    //Will be executed only when non-nil
                    viewController.id = "4"
                    viewController.c_mall = c_mall
                }

                
            }
        }
    }

}
