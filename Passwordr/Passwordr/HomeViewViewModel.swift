//
//  HomeViewViewModel.swift
//  Passwordr
//
//  Created by Rafael Plinio on 15/11/23.
//

import Foundation
import LocalAuthentication

extension HomeView {
    @MainActor class HomeViewViewModel: ObservableObject {
        private(set) var context = LAContext()
        @Published private(set) var biometryType: LABiometryType = .none
        private(set) var canEvaluatePolicy = false
        @Published private(set) var isAuthenticated = false
        @Published private(set) var errorDescription: String?
        @Published var showAlert = false
        
        // On initialize of this class, get the biometryType, which for this app is only FaceID
        init() {
            getBiometryType()
        }
        
        func getBiometryType() {
            // canEvaluatePolicy will let us know if the user's device supports biometrics authentication
            canEvaluatePolicy = context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
            
            // Getting the biometryType - in other words, if the device supports FaceID, TouchID, or doesn't support biometrics auth
            biometryType = context.biometryType
        }
        
        func authenticateWithFaceID() async {
            // Resetting the LAContext so on the next login, biometrics are checked again
            context = LAContext()
            
            // Only evaluatePolicy if device supports biometrics auth
            if canEvaluatePolicy {
                let reason = "TO UNLOCK PASSWORDR"
                
                do {
                    // evaluatePolicy will check if user is the device's owner, returns a boolean value that'll let us know if it successfully identified the user
                    let success = try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason)
                    
                    // Only if it's a success, we'll set isAuthenticated to true
                    if success {
                        Task {
                            await MainActor.run {
                                self.isAuthenticated = true
                                print("isAuthenticated", self.isAuthenticated)
                            }
                        }
                    }
                } catch {
                    print(error.localizedDescription)

                    /// Uncomment the code below if error handling for authentication with biometrics is needed
                    /// If there is an error, set the errorDescription,  show an alert
//                    Task {
//                        await MainActor.run {
//                            self.errorDescription = error.localizedDescription
//                            self.showAlert = true
//                            self.biometryType = .none
//                        }
//                    }
                }
            }
        }
        
        // Logout the user - just setting back isAuthenticated to false
        func logout() {
            isAuthenticated = false
        }
    }
}
