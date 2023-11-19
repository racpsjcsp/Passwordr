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
    var name: String
    @Attribute(.allowsCloudEncryption) var username: String
    @Attribute(.allowsCloudEncryption) var password: String
    
    init(name: String, username: String, password: String) {
        self.name = name
        self.username = username
        self.password = password
    }
}
