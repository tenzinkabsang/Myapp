import Foundation

final class EventService {
    static let shared = EventService()
        
    func getAllEvents(distance: Double) async throws -> [Event] {
        //let events: [Event] = try await Util.fetch(from: "/events")
        //return events
        
        return EventList.allEvents
    }
    
    func getEvent(id: String) async throws -> Event {
        let event: Event = try await Util.fetch(from: "/events/documentId")
        return event
    }
}

final class UserService {
    static let shared = UserService()
    
    func getUser() async throws -> User {
        let currentUser: User = try await Util.fetch(from: "/users")
        return currentUser
    }
}
