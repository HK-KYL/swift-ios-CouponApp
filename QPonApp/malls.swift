//
//  malls.swift
//  QPonApp
//
//  Created by K on 9/10/2018.
//  Copyright © 2018 HKBU-KYL. All rights reserved.
//

import Foundation
import RealmSwift

class malls: Object {
    @objc dynamic var Mall: String? = nil
    let Latitude = RealmOptional<Double>()
    let Longitude = RealmOptional<Double>()
    @objc dynamic var District: String? = nil
}
