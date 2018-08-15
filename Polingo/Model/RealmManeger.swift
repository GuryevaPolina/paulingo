//
//  RealmManeger.swift
//  Polingo
//
//  Created by Polina Guryeva on 15.08.2018.
//  Copyright © 2018 polinaguryeva. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    var realm = try! Realm()
    
    var allUsers: Results<User> {
        get {
            return realm.objects(User.self)
        }
    }
    
    var currentUser: Results<CurrentUser> {
        get {
            return realm.objects(CurrentUser.self)
        }
    }
    
}
