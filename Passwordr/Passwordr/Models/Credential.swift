//
//  Credential.swift
//  Passwordr
//
//  Created by Rafael Plinio on 15/11/23.
//

import Foundation
import SwiftData

@Model
class Credential {
    var name: String = "testeNameame"
    var username: String = "testeUsername"
    var password: String = "testePassword"
    
    init(name: String, username: String, password: String) {
        self.name = name
        self.username = username
        self.password = password
    }
}
