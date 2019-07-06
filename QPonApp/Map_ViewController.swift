//
//  Map_ViewController.swift
//  QPonApp
//
//  Created by K on 9/10/2018.
//  Copyright © 2018 HKBU-KYL. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class Map_ViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    var c_qpon:Feed?
    var latitude:Double? = 22.3380838
    var longitude:Double? = 114.18186
    
    var RLM_Malls:Results<malls>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let config = Realm.Configuration(
            fileURL: Bundle.main.url(forResource: "MallsInfo", withExtension: "realm"),
            readOnly: true
        )

        let realm = try! Realm(configuration: config)
        if let q = c_qpon {
            print(q.mall!)
            RLM_Malls = realm.objects(malls.self).filter("Mall = \"\(q.mall!)\"")
            print(RLM_Malls)
        }
        
        if let c_mall = RLM_Malls?[0] {
            latitude = c_mall.Latitude.value
            longitude = c_mall.Longitude.value
        }

        let initialLocation = CLLocation(latitude: latitude!, longitude: longitude!)
        
        let regionRadius: CLLocationDistance = 300
        
        let coordinateRegion = MKCoordinateRegion(
            center: initialLocation.coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        
        let mallPoint = MKPointAnnotation()
        
        mallPoint.coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        if let q = c_qpon {
            mallPoint.title = q.mall!
            mallPoint.subtitle = q.mall!
        }
        
        mapView.addAnnotation(mallPoint)
        
        mapView.setRegion(coordinateRegion, animated: true)
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
