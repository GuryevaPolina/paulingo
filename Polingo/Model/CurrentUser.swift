//
//  CurrentUser.swift
//  Polingo
//
//  Created by Polina Guryeva on 15.08.2018.
//  Copyright © 2018 polinaguryeva. All rights reserved.
//

import Foundation
import RealmSwift

final class CurrentUser: Object {
    @objc dynamic var username = ""
    @objc dynamic var password = ""
}

