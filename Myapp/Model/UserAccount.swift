//
//  UserAccount.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/22/22.
//

import Foundation
import FirebaseAuthUI
import Resolver

struct UserAccount: Codable {
    var userId : String?
    var email: String?
    var displayName: String?
    var profileImageUrl: String?
    
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

class UserAccountViewModel : NSObject, ObservableObject, FUIAuthDelegate {
    
    @Injected var userRepository: IUserRepository
    
    @Published private var user : UserAccount = Keystore.shared.load()
    
    //@Published var userId: String?
//    @Published var displayName: String?
//    @Published var email: String?
//    @Published var profileImageUrl: String?
    
    var userId: String? {
        get {
            user.userId
        }
    }
    
    var displayName: String? {
        get {
            user.displayName
        }
    }
    
    var email: String? {
        get {
            user.email
        }
    }
    
    var profileImageUrl: String? {
        get {
            user.profileImageUrl
        }
    }
    
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
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        if let error = error {
            print("Error::\(error)")
            return
        }
        
        if let result = authDataResult {
            self.user.hasSignedIn = true
            self.user.userId = result.user.uid
                        
            if let name = result.user.displayName {
                self.user.displayName = name
            }
            
            if let email = result.user.email {
                self.user.email = email
            }
            
//            if let photoUrl = result.user.photoURL {
//                self.user.profileImageUrl = photoUrl.absoluteString
//            }
            
            
            saveUser(self.user)
        }
    }
    
    private func saveUser(_ user: UserAccount) {
        
        Keystore.shared.save(user)
        
        Task {
            let currentUser = try await userRepository.fetchUserAsync(userId: user.userId!)
                        
            // User does not exist, then we create one in firestore
            if currentUser == nil {
                let newUser = User(id: user.userId,
                                   displayName: user.displayName ?? "",
                                   email: user.email ?? "",
                                   profileImageUrl: user.profileImageUrl ?? "",
                                   location: Location(latitude: "", longitude: ""))
                
                userRepository.createUser(newUser)
                
                print("User created: \(newUser.email)")
            }
        }
    }
    
    func updateUser(profileImgUrl: String) {
        
        // Update local user data
        user.profileImageUrl = profileImgUrl
        Keystore.shared.save(user)
        
        // Update database
        let newUser = User(id: user.userId,
                           displayName: user.displayName ?? "",
                           email: user.email ?? "",
                           profileImageUrl: profileImgUrl)
        
        userRepository.createUser(newUser)
        
        print("User updated: \(newUser.email)")
        
        //user = Keystore.shared.load()
    }
    
    
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

