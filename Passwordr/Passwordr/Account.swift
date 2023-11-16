//
//  Account.swift
//  Passwordr
//
//  Created by Rafael Plinio on 15/11/23.
//

import Foundation

class Account {
    var username: String
    var password: String
    
    init(login: String, password: String) {
        self.username = login
        self.password = password
    }
}
