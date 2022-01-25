import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Hashable, Identifiable {
    @DocumentID var id: String?
    var username: String
    var email: String
    var firstName: String
    var lastName: String
    var location: Location  // Rande<Double> maybe...
    var profileImageUrl: String
    @ServerTimestamp var createdAt: Date?
    @ServerTimestamp var lastUpdateAt: Date?
}

struct Event: Codable, Hashable, Identifiable {
    @DocumentID var id: String?
    var author: UserInfo
    var category: String
    var eventImageUrl: String
    var isExpired: Bool
    var title: String
    var location: Location
    @ServerTimestamp var createdAt: Date? // lifetime of 20 min
    
    var eventUpdates: [EventUpdate]?
}

struct EventUpdate: Codable, Hashable, Identifiable {
    @DocumentID var id: String?
    var guest: UserInfo
    var comments: [String]
    var images: [String]
    @ServerTimestamp var createdAt: Date?
}

struct Location: Codable, Hashable {
    var latitude: String
    var longitude: String
}

struct UserInfo: Codable, Hashable {
    var userId: String
    var username: String
    var profileImageUrl: String
}

