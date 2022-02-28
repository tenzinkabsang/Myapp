//
//  MyappApp.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/19/22.
//

import SwiftUI
import Firebase
import Resolver

@main
struct MyappApp: App {
    /**
     @StateObject to initialize only once during the lifetime of the app - singleton
     */
    @StateObject private var currentUser = UserProfile()
    
    @StateObject private var userAccountViewModel = UserAccountViewModel()
    
    
    init() {
        FirebaseApp.configure()
        Resolver.registerAllServices()
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(userAccountViewModel)
        }
        
    }
    
}

final class UserProfile :ObservableObject {
    @Injected var userRepository: IUserRepository
    
    @EnvironmentObject private var userAccountViewModel : UserAccountViewModel
    
    
    @Published var userx = User(id: "",
                               displayName: "",
                               email: "",
                                profileImageUrl: "",
                               location: Location(latitude: "", longitude: "")
                             )
    
    @Published var user: User?
    
    
    
    @MainActor
    public func tryGetUser(userId: String) {
        Task {
            self.user = try await userRepository.fetchUserAsync(userId: userId)
        }
    }
    
}
