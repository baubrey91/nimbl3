//
//  User.swift
//  nimbl3
//
//  Created by Brandon Aubrey on 8/24/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import Foundation

class User {
    
    //Singleton to create global user
    static var currentUser: User?
    
    var token: String?
    var userName: String?
    
    init(token: String, userName: String) {
        self.token = token
        self.userName = userName
    }
}
