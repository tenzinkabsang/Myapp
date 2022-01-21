import Foundation

struct User: Codable, Hashable, Identifiable {
    var id: String
    var username: String
    var email: String
    var firstName: String
    var lastName: String
    var location: Location  // Rande<Double> maybe...
    var profileImageUrl: String
}

struct Event: Codable, Hashable, Identifiable {
    var id: String
    var author: UserInfo
    var category: String
    var eventImageUrl: String
    var isExpired: Bool
    var title: String
    var location: Location
    var startTime: Date // lifetime of 20 min
    
    var eventUpdates: [EventUpdate]
}

struct EventUpdate: Codable, Hashable, Identifiable {
    var id: String
    var guest: UserInfo
    var comments: [String]
    var images: [String]
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

