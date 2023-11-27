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
    @Attribute(.allowsCloudEncryption) var name: String
    @Attribute(.allowsCloudEncryption) var oldName: String
    @Attribute(.allowsCloudEncryption) var username: String
    @Attribute(.allowsCloudEncryption) var oldUsername: String
    @Attribute(.allowsCloudEncryption) var password: String
    @Attribute(.allowsCloudEncryption) var oldPassword: String
    @Attribute(.allowsCloudEncryption) var creationDate: String
    @Attribute(.allowsCloudEncryption) var lastChanged: String

    init(name: String, oldName: String, username: String, oldUsername: String, password: String, oldPassword: String, creationDate: String, lastChanged: String) {
        self.name = name
        self.oldName = oldName
        self.username = username
        self.oldUsername = oldUsername
        self.password = password
        self.oldPassword = oldPassword
        self.creationDate = creationDate
        self.lastChanged = lastChanged
    }
}
