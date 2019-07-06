//
//  Feed.swift
//  QPonApp
//
//  Created by K on 9/10/2018.
//  Copyright © 2018 HKBU-KYL. All rights reserved.
//

import Foundation
import RealmSwift

class Feed: Object {
    @objc dynamic var title: String? = nil
    @objc dynamic var restarant: String? = nil
    var coin = RealmOptional<Int>()
    @objc dynamic var date: String? = nil
    @objc dynamic var district: String? = nil
    @objc dynamic var mall: String? = nil
    @objc dynamic var quota: String? = nil
    @objc dynamic var image: String? = nil
    @objc dynamic var details: String? = nil
    @objc dynamic var createdAt: String? = nil
    @objc dynamic var updatedAt: String? = nil
    @objc dynamic var _id: String? = nil
}
