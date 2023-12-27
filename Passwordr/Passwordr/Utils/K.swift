//
//  K.swift
//  Passwordr
//
//  Created by Rafael Plinio on 24/11/23.
//

import Foundation

struct K {
    struct Strings {

        // Auth Screen
        static let appTitle = "Passwordr"
        static let authScreenTitle = "Login with Biometry"
        static let unlockPasswordr = "To unlock Passwordr"

        // HomeView
        static let homeNavTitle = "Credentials"
        static let homeNoCredentialLabel = "No Credentials"
        static let homeCredentialDescription = "Add a new credential to start"
        static let homeAddCredentialTitle = "Add Credential"

        // AddCredentialSheet
        static let addCredentialNavTitle = "New Credential"

        // UpdateCredentialSheet
        static let updateCredentialNavTitle = "Edit Credential"
        static let updateCredentialHeader = "Credential"
        static let updateCredentialFooter = "Edit any field as needed"
        static let updateOldCredential = "Old Credential"
        static let updateCredentialInfoCreated = "Created:"
        static let updateCredentialInfoUpdated = "Updated:"
        static let updateCredentialInfoHeader = "Information"

        // PasswordGeneneratorView
        static let passwordGeneratorNavTitle = "Password Generator"
        static let passwordHowManyCharacters = "How many characters?"
        static let passwordIncludeSymbol = "Include Symbol"
        static let passwordIncludeNumber = "Include Number"
        static let passwordIncludeEmptySpace = "Include Space"
        static let passwordIncludeUpperCase = "Include Upper Case"
        static let generatePassword = "Generate Password"

        // TipView
        static let tipViewNavTitle = "Tip Me"
        static let tipViewTitle = "Enjoying the App? 🤓"
        static let tipViewDescription = "Passwordr is a free App, which I created for my own use because I don't need any extra complicated feature as of now. If that changes then I will, overtime, implement new features. If you like it and are feeling generous, consider tipping. It will surely help me to keep the app up to date. Any tip will be very much appreciated."

        // ThanksView
        static let thanksViewTitle = "Thank You 💕"
        static let thanksViewDescription = "Your tip is very much appreciated. Will do my best to keep this app neat!"
        static let thanksViewButtonTitle = "Close"

        // General
        static let cancelButton = "Cancel"
        static let saveButton = "Save"
        static let title = "Title"
        static let oldTitle = "Old Title"
        static let username = "Login/Username"
        static let password = "Password"
        static let oldPassword = "Old Password (Optional)"
        static let creationDate = ""
        static let lastChanged = ""
        static let clipboardMessage = "Copied to clipboard!"
        static let clipboardPasswordMessage = "Copied to clipboard (60s)"
        static let copy = "Copy"

        // Tabs
        static let passwordGenerator = "Password Generator"
        static let tipMe = "Tip Me"

        // Previews
        static let credentialScreenEmpty = "Credential Screen Empty"
        static let credentialScreen = "Credential Screen"
    }

    struct Image {
        static let passwordrLogo = "passwordrLogo"
        static let faceID = "faceid"
        static let newspaper = "newspaper"
        static let plus = "plus"
        static let personFill = "person.fill"
        static let pencil = "pencil"
        static let docOndoc = "doc.on.doc"
        static let eye = "eye"
        static let eyeSlash = "eye.slash"
        static let wandAndStars = "wand.and.stars"
        static let dollarsignCircle = "dollarsign.circle"
        static let triangleFill = "triangle.fill"
        static let sliderHorizontalMenu = "slider.horizontal.3"
        static let squareAndArrowUp = "square.and.arrow.up"
    }
}
