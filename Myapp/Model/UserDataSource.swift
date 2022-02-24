//
//  UserDataSource.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/22/22.
//

import Foundation

// TODO: implement keychain
struct Keystore {
    static let shared = Keystore()
    private let key = "com.myapp.savedUser"
    
    func save(_ user: UserAccount) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key)
        }
    }
    
    func load() -> UserAccount {
        let defaults = UserDefaults.standard
        if let savedUser = defaults.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(UserAccount.self, from: savedUser) {
                return loadedUser
            }
        }
        
        return UserAccount()
    }
    
    func removeUser() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
    }
}
