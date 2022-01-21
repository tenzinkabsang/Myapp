//
//  MyappApp.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/19/22.
//

import SwiftUI
import Firebase

@main
struct MyappApp: App {
    /**
     @StateObject to initialize only once during the lifetime of the app - singleton
     */
    @StateObject private var currentUser = CurrentUserInfo()
    
    
    init() {
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(currentUser)
        }
        
    }
    
}

final class CurrentUserInfo :ObservableObject {
    //var user: User = User(id: "", username: "", email: "", firstName: "", lastName: "", location: Location(latitude: "", longitude: ""), profileImageUrl: "")
    
    @Published var user = User(id: "",
                               username: "",
                               email: "",
                               firstName: "",
                               lastName: "",
                               location: Location(latitude: "", longitude: ""),
                               profileImageUrl: "")
    
    init() {
        getCurrentUser()
    }
    
    func getCurrentUser() {
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document("id")
        
        docRef.getDocument { d, error in
            if error == nil {
                if let d = d {
                    DispatchQueue.main.async {
                        self.user = User(id: d.documentID,
                                         username: d["username"] as? String ?? "",
                                         email: d["email"] as? String ?? "",
                                         firstName: d["firstName"] as? String ?? "",
                                         lastName: d["lastName"] as? String ?? "",
                                         location: Location(latitude: d["location.latitude"] as? String ?? "",
                                                            longitude: d["location.longitude"] as? String ?? ""),
                                         profileImageUrl: d["profileImageUrl"] as? String ?? "")
                    }
                }
            } else {
                // Handle error if user not found
            }
        }
    }
}
