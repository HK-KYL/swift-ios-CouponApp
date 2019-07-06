//
//  Login_ViewController.swift
//  QPonApp
//
//  Created by K on 10/10/2018.
//  Copyright © 2018 HKBU-KYL. All rights reserved.
//

import UIKit
import Alamofire

class Login_ViewController: UIViewController {

    @IBOutlet var userid: UITextField!
    @IBOutlet var password: UITextField!
    @IBAction func loginBtn(_ sender: Any) {
        let parameters:Parameters = ["username": userid.text!, "password": password.text!]
        
        Alamofire.request("https://shielded-ravine-22988.herokuapp.com/user/login", method: .post, parameters: parameters).responseString {
            response in
            
            print("[Login_ViewController] Login Result: \(response.result.value ?? "No data")")
            
            let alertController = UIAlertController(title: "QPon", message: response.result.value, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Alamofire.request("https://shielded-ravine-22988.herokuapp.com/user/logout", method: .post).responseString {
            response in print("[Login_ViewController] Logout Result: OK") //  \(response.result.value ?? "No data")
            
            let alertController = UIAlertController(title: "Message", message: "Logoff successfully.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
