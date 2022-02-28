//
//  FirebaseManager.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/26/22.
//

import Foundation
import Firebase

class FirebaseManager: NSObject {
    
    let auth: Auth
    let storage: Storage
    
    static let shared = FirebaseManager()
    
    override init() {
        //FirebaseApp.configure()
        self.auth = Auth.auth()
        self.storage = Storage.storage()
                
        super.init()
    }
}



