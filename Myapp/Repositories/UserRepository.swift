//
//  UserRepository.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/23/22.
//



import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol IUserRepository {
    func fetchUserAsync(userId: String) async throws -> User?
    func createUser(_ user: User)
}

class UserRepository: IUserRepository {
    private let path: String = "users"
    private let db = Firestore.firestore()
    
    func fetchUserAsync(userId: String) async throws -> User? {
        let userSnapshot = try await db.collection(path).whereField("id", isEqualTo: userId).getDocuments()
        
        return userSnapshot.documents.compactMap { document in
            try? document.data(as: User.self)
        }.first
    }
    
    func createUser(_ user: User) {
        do {
            let _ = try db.collection(path).document(user.id!).setData(from: user, merge: true)
        }
        catch {
            print(error)
        }
    }
    
}

