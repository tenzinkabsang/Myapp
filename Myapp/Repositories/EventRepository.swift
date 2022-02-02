import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine



class BaseEventRepository {
    @Published var liveTilesEvents = [Event]()
    @Published var events = [Event]()
}

protocol IEventRepository: BaseEventRepository {
    func fetchEventsAsync() async throws -> [Event]
    func fetchEventReelsAsync() async throws -> [Event]
    func fetchEventInfo(_ eventId: String) -> AnyPublisher<EventInfo?, Error>
    func fetchEventInfo(_ eventId: String) async throws -> EventInfo? 
    
    func addEvent(_ event: Event)
    func addEventUpdate(eventId: String, eventUpdate: EventUpdate)
    func updateEventUpdate(eventId: String, eventUpdate: EventUpdate)
    func loadData()
}


class EventRepository: BaseEventRepository, IEventRepository, ObservableObject {
   
    private let path: String = "events"
    private let db = Firestore.firestore()
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published private var tempEvents = [Event]()
    
    override init() {
        super.init()
        //loadData()
    }
    
    func fetchEventsAsync() async throws -> [Event] {
        let eventSnapshot = try await db.collection(path).getDocuments()
        
        return eventSnapshot.documents.compactMap { document in
            try? document.data(as: Event.self)
        }
    }
    
    
    func fetchEventReelsAsync() async throws -> [Event] {
        let eventSnapshot = try await db.collection(path).getDocuments()
        
        return eventSnapshot.documents.compactMap { document in
            try? document.data(as: Event.self)
        }
    }
    
    
    func fetchEventInfo(_ eventId: String) async throws -> EventInfo? {
        let snapshot = try await db.collection("eventInfos").whereField("eventId", isEqualTo: eventId).getDocuments()
        
        return snapshot.documents.compactMap { document in
            try? document.data(as: EventInfo.self)
        }.first
    }
    
    func fetchEventInfoTest(_ eventId: String) async throws -> EventInfo? {
        let snapshot = try await db.collection("eventInfos").whereField("eventId", isEqualTo: eventId).getDocuments()
        
        return snapshot.documents.compactMap { document in
            try? document.data(as: EventInfo.self)
        }.first
    }
    
    
    func fetchEventInfo(_ eventId: String) -> AnyPublisher<EventInfo?, Error> {
        Future<EventInfo?, Error> { promise in
            self.db.collection("eventInfos")
                .whereField("eventId", isEqualTo: eventId)
                .addSnapshotListener { snapshot, error in
                    if let error = error {
                        promise(.failure(error))
                        return
                    }
                    
                    guard let snapshot = snapshot else {
                        //promise(.failure(Error))
                        return
                    }
                    let eventInfo = snapshot.documents.compactMap { document in
                        try? document.data(as: EventInfo.self)
                    }.first
                    
                    promise(.success(eventInfo))
                }
        }
        .eraseToAnyPublisher()
    }
    
    
    
    func loadData() {
        fetchLiveTilesData()
        fetchEvents()
        
//        $tempEvents
//            .sink { events in
//                events.forEach { event in
//                    self.fetchEventAndUpdates(event)
//                }
//            }
//            .store(in: &cancellables)
            
    }
    
    
    func fetchEventXX() -> AnyPublisher<[Event], Error> {
        Future<[Event], Error> { promise in
            self.db.collection(self.path)
                .getDocuments { snapshot, error in
                    if let error = error {
                        promise(.failure(error))
                        return
                    }
                    
                    guard let snapshot = snapshot else {
                        //promise(.failure(error))
                        return
                    }
                    let events = snapshot.documents.compactMap { document in
                        try? document.data(as: Event.self)
                    }
                    
                    promise(.success(events))
                }
        }
        .eraseToAnyPublisher()
    }
    
    
    
    
    func fetchEvents() {
        // 1. Get events
        db.collection(path).getDocuments { snapshot, error in
            if let error = error {
                print("Error getting events: \(error.localizedDescription)")
                return
            }
            
            if let querySnapshot = snapshot {
                self.events = querySnapshot.documents.compactMap { eventQuerySnapshot in
                    return Event(id: eventQuerySnapshot.documentID,
                                 author: UserInfo(userId: eventQuerySnapshot["author.userId"] as? String ?? "",
                                                  username: eventQuerySnapshot["author.username"] as? String ?? "",
                                                  profileImageUrl: eventQuerySnapshot["author.profileImageUrl"] as? String ?? ""),
                                 category: eventQuerySnapshot["category"] as? String ?? "",
                                 eventImageUrl: eventQuerySnapshot["eventImageUrl"] as? String ?? "",
                                 isExpired: eventQuerySnapshot["isExpired"] as? Bool ?? true,
                                 title: eventQuerySnapshot["title"] as? String ?? "",
                                 location: Location(latitude: eventQuerySnapshot["location.latitude"] as? String ?? "", longitude: eventQuerySnapshot["location.longitude"] as? String ?? ""),
                                 createdAt: eventQuerySnapshot["createdAt"] as? Date ?? Date(),
                                 eventUpdates: [EventUpdate]())
                }
            }
        }
    }
    
    private func fetchLiveTilesData() {
        db.collection(path).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting events: \(error.localizedDescription)")
                return
            }
            
            if let querySnapshot = querySnapshot {
                self.liveTilesEvents = querySnapshot.documents.compactMap { eventQuerySnapshot -> Event? in
                    //return try? querySnapshot.data(as: Event.self)
                    
                   let tempEvent = Event(id: eventQuerySnapshot.documentID,
                          author: UserInfo(userId: eventQuerySnapshot["author.userId"] as? String ?? "",
                                           username: eventQuerySnapshot["author.username"] as? String ?? "",
                                           profileImageUrl: eventQuerySnapshot["author.profileImageUrl"] as? String ?? ""),
                          category: eventQuerySnapshot["category"] as? String ?? "",
                          eventImageUrl: eventQuerySnapshot["eventImageUrl"] as? String ?? "",
                          isExpired: eventQuerySnapshot["isExpired"] as? Bool ?? true,
                          title: eventQuerySnapshot["title"] as? String ?? "",
                          location: Location(latitude: eventQuerySnapshot["location.latitude"] as? String ?? "", longitude: eventQuerySnapshot["location.longitude"] as? String ?? ""),
                          createdAt: eventQuerySnapshot["createdAt"] as? Date ?? Date(),
                          eventUpdates: [EventUpdate]())
                    
                    return tempEvent
                }
            }
        }
    }
    
    private func fetchEventsx() {
        db.collection(path).getDocuments { snapshot, error in
            if let error = error {
                print("Error getting events: \(error.localizedDescription)")
                return
            }
            
            if let querySnapshot = snapshot {
                self.events = querySnapshot.documents.compactMap{ eventQuerySnapshot in
                    
                    // Get subcollection data
//                    let subcollectionPath = "\(self.path)/\(eventQuerySnapshot.documentID)/eventUpdates"
//                    print(subcollectionPath)
//
//                    var eventUpdates = [EventUpdate]()
//                    self.db.collection(subcollectionPath).order(by: "createdAt", descending: true).addSnapshotListener { sub, error in
//                            if let error = error {
//                                print("Error getting events: \(error.localizedDescription)")
//                                return
//                            }
//
//                            if let sub = sub {
//                                eventUpdates = sub.documents.compactMap { d -> EventUpdate? in
//                                    //return try? d.data(as: EventUpdate.self)
//
//                                    return EventUpdate(id: d.documentID,
//                                                       guest: UserInfo(userId: d["author.userId"] as? String ?? "",
//                                                                       username: d["author.username"] as? String ?? "",
//                                                                       profileImageUrl: d["author.profileImageUrl"] as? String ?? ""),
//                                                       comments: d["comments"] as? [String] ?? [],
//                                                       images: d["images"] as? [String] ?? [],
//                                                       createdAt: d["createdAt"] as? Date ?? Date())
//                                }
//                            }
//                        }
//
//                    let tempEvent = try? eventQuerySnapshot.data(as: Event.self)
//
//                    return Event(id: tempEvent!.id,
//                                 author: tempEvent!.author,
//                                 category: tempEvent!.category,
//                                 eventImageUrl: tempEvent!.eventImageUrl,
//                                 isExpired: tempEvent!.isExpired,
//                                 title: tempEvent!.title,
//                                 location: tempEvent!.location,
//                                 createdAt: tempEvent!.createdAt,
//                                 eventUpdates: eventUpdates)
                    
                   let tempEvent = Event(id: eventQuerySnapshot.documentID,
                          author: UserInfo(userId: eventQuerySnapshot["author.userId"] as? String ?? "",
                                           username: eventQuerySnapshot["author.username"] as? String ?? "",
                                           profileImageUrl: eventQuerySnapshot["author.profileImageUrl"] as? String ?? ""),
                          category: eventQuerySnapshot["category"] as? String ?? "",
                          eventImageUrl: eventQuerySnapshot["eventImageUrl"] as? String ?? "",
                          isExpired: eventQuerySnapshot["isExpired"] as? Bool ?? true,
                          title: eventQuerySnapshot["title"] as? String ?? "",
                          location: Location(latitude: eventQuerySnapshot["location.latitude"] as? String ?? "", longitude: eventQuerySnapshot["location.longitude"] as? String ?? ""),
                          createdAt: eventQuerySnapshot["createdAt"] as? Date ?? Date(),
                          eventUpdates: [EventUpdate]())
                    
                    return tempEvent
                    
                }
            }
        }
        
    }
    
    
    func addEvent(_ event: Event) {
        do {
            _ = try db.collection(path).addDocument(from: event)
        } catch {
            fatalError("Unable to create event!")
        }
    }
    
    func addEventUpdate(eventId: String, eventUpdate: EventUpdate) {
        do {
            _ = try db.collection(path).document(eventId).collection("eventUpdates").addDocument(from: eventUpdate)
        } catch {
            fatalError("Unable to add eventUpdate")
        }
    }
    
    func updateEventUpdate(eventId: String, eventUpdate: EventUpdate) {
        do {
            _ = try db.collection(path).document(eventId)
                .collection("eventUpdates").document(eventUpdate.id!).setData(from: eventUpdate, merge: true)
        } catch {
            fatalError("Unable to add eventUpdate")
        }
    }
}

