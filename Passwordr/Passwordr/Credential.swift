//
//  Password.swift
//  Passwordr
//
//  Created by Rafael Plinio on 15/11/23.
//

import Foundation

class Credential {
    var login: String
    var password: String
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
}
