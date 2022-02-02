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
    var comments: [UserComment]
    var images: [UserImage]
    @ServerTimestamp var createdAt: Date?
}

struct UserImage: Codable, Hashable {
    var userId: String
    var username: String
    var profileImageUrl: String
    
    @ServerTimestamp var createdAt: Date?
    var imageUrl: String
}

struct UserComment: Codable, Hashable {
    var userId: String
    var username: String
    var profileImageUrl: String
    @ServerTimestamp var createdAt: Date?
    var comment: String
}

struct EventInfo: Codable, Hashable, Identifiable {
    @DocumentID var id: String?
    var eventId: String
    var guestIds: [String]
    var numberOfGuests: Int
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

