//
//  File.swift
//  realmTest
//
//  Created by Jake Lin on 22/03/2018.
//  Copyright © 2018 ttyUSB0978. All rights reserved.
//

import Foundation
import RealmSwift

class myCharacter: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var picture: Data? = nil
    @objc dynamic var name = ""
    @objc dynamic var job = ""
    @objc dynamic var exp = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

