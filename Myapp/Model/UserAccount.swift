//
//  UserAccount.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/22/22.
//

import Foundation
import FirebaseAuthUI

struct UserAccount: Codable {
    var userId : String = ""
    var email: String = ""
    var displayName: String = ""
    
    private var signedIn: Bool = false
    
    var hasSignedIn: Bool {
        set(newSignedIn) {
            self.signedIn = newSignedIn
        }
        
        get {
            return self.signedIn && AuthManager.shared.isSignedIn()
        }
    }
}

class UserAccountViewModel : NSObject, ObservableObject {
    @Published private var user = Keystore.shared.load()
    
    override init() {
        super.init()
        AuthManager.shared.setAuthDelegate(self)
    }
    
    var hasSignedIn: Bool {
        get {
            user.hasSignedIn
        }
        set(newHasSignedIn) {
            user.hasSignedIn = newHasSignedIn
        }
    }
    
    var userId: String {
        user.userId
    }
    
    var displayName: String {
        user.displayName
    }
    
    var userEmail: String {
        user.email
    }
}

extension UserAccountViewModel : FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?){
        
        if let error = error {
            print("Error::\(error)")
            return
        }
        
        if let result = authDataResult {
            self.user.hasSignedIn = true
            if let name = result.user.displayName {
                self.user.displayName = name
            }
            
            if let email = result.user.email {
                self.user.email = email
            }
            
            self.user.userId = result.user.uid
            
            Keystore.shared.save(user)
        }
    }
}

extension UserAccountViewModel {
    func signOut() {
        AuthManager.shared.signOut { error in
            if let error = error {
                print("Signed out error: \(error)")
            } else {
                self.user.hasSignedIn = false
                Keystore.shared.removeUser()
            }
        }
    }
}
