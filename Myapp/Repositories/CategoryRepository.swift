//
//  CategoryRepository.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/7/22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol ICategoryRepository {
    func fetchAllCategoriesAsync() async throws -> [Category]
}

class CategoryRepository: ICategoryRepository {
    private let path: String = "categories"
    private let db = Firestore.firestore()
    
    func fetchAllCategoriesAsync() async throws -> [Category] {
        let categorySnapshot = try await db.collection(path).getDocuments()
        
        return categorySnapshot.documents.compactMap { document in
            try? document.data(as: Category.self)
        }
    }
    
}


struct Category: Codable, Hashable, Identifiable {
    @DocumentID var id: String?
    var name: String
}
