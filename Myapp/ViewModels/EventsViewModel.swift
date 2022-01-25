import Foundation
import FirebaseFirestore

class FullEventViewModel: ObservableObject {
    @Published var event: Event
    @Published var eventUpdates: [EventUpdate]
    
    @Published var numberOfGuests: String
    
    init(event: Event, guests: [EventUpdate]) {
        self.event = event
        self.eventUpdates = guests
        self.numberOfGuests = FullEventViewModel.getNumberOfGuests(guests)
    }
    
    private static func getNumberOfGuests(_ eventUpdates: [EventUpdate]) -> String {
        let number = eventUpdates.count
        
        return "\(number) going"
    }
}

class EventsViewModel: ObservableObject {
    @Published var events = [Event]()
    
    private var db = Firestore.firestore()
    
    
    func fetchEvents() {
        
        db.collection("events").getDocuments { snapshot, error in
            if let querySnapshot = snapshot {
                
                var eventUpdates = [EventUpdate]()
                for document in querySnapshot.documents {
                    document.reference.collection("eventUpdates").getDocuments{ eventUpdateSnapshot, error in
                        
                        if let eventUpdateSnapshot = eventUpdateSnapshot {
                            eventUpdates = eventUpdateSnapshot.documents.compactMap { ed -> EventUpdate? in
                                return try? ed.data(as: EventUpdate.self)
                            }
                        }
                    }
                }
                
                self.events = querySnapshot.documents.compactMap { d in
                    
                   
                    let event = Event(id: d.documentID,
                                      author: UserInfo(userId: d["author.userId"] as? String ?? "",
                                                       username: d["author.username"] as? String ?? "",
                                                       profileImageUrl: d["author.profileImageUrl"] as? String ?? ""),
                                      category: d["category"] as? String ?? "",
                                      eventImageUrl: d["eventImageUrl"] as? String ?? "",
                                      isExpired: d["isExpired"] as? Bool ?? true,
                                      title: d["title"] as? String ?? "",
                                      location: Location(latitude: d["location.latitude"] as? String ?? "", longitude: d["location.longitude"] as? String ?? ""),
                                      createdAt: d["createdAt"] as? Date ?? Date(),
                                      eventUpdates: eventUpdates)
                    
                    return event
                    
                }
            }
        }
        
//        // 1. Get all the events
//        db.collection("events").whereField("isExpired", isEqualTo: false).getDocuments { snapshot, error in
//            if let error = error {
//                print("Error getting events: \(error.localizedDescription)")
//                return
//            }
//
//            if let querySnapshot = snapshot {
//                self.events = querySnapshot.documents.compactMap{ d -> Event? in
//                    return try? d.data(as: Event.self)
//
//
//                }
//            }
//        }
    }
    
    
    func fetchDataManual() {
        db.collection("events").whereField("isExpired", isEqualTo: false).getDocuments { snapshot, error in
            if let error = error {
                print("Error getting events: \(error.localizedDescription)")
                return
            }
            
            if let querySnapshot = snapshot {
                // DispatchQueue.main.async {
                self.events = querySnapshot.documents.compactMap{ d in
                    let event = Event(id: d.documentID,
                                      author: UserInfo(userId: d["author.userId"] as? String ?? "",
                                                       username: d["author.username"] as? String ?? "",
                                                       profileImageUrl: d["author.profileImageUrl"] as? String ?? ""),
                                      category: d["category"] as? String ?? "",
                                      eventImageUrl: d["eventImageUrl"] as? String ?? "",
                                      isExpired: d["isExpired"] as? Bool ?? true,
                                      title: d["title"] as? String ?? "",
                                      location: Location(latitude: d["location.latitude"] as? String ?? "", longitude: d["location.longitude"] as? String ?? ""),
                                      createdAt: d["createdAt"] as? Date ?? Date(),
                                      eventUpdates: [EventUpdate]())
                                       
                    return event
                }
                // }
            }
            
        }
    }
    
    
    func fetchDataManualx() {
        db.collection("events").whereField("isExpired", isEqualTo: false).addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error getting events: \(error.localizedDescription)")
                return
            }
            
            if let querySnapshot = querySnapshot {
                self.events = querySnapshot.documents.compactMap{ d in
                    Event(id: d.documentID,
                          author: UserInfo(userId: d["author.userId"] as? String ?? "",
                                           username: d["author.username"] as? String ?? "",
                                           profileImageUrl: d["author.profileImageUrl"] as? String ?? ""),
                          category: d["category"] as? String ?? "",
                          eventImageUrl: d["eventImageUrl"] as? String ?? "",
                          isExpired: d["isExpired"] as? Bool ?? true,
                          title: d["title"] as? String ?? "",
                          location: Location(latitude: d["location.latitude"] as? String ?? "", longitude: d["location.longitude"] as? String ?? ""),
                          createdAt: d["createdAt"] as? Date ?? Date(),
                          eventUpdates: [EventUpdate]())
                }
            }
            
        }
    }
    
    func fetchData() {
        db.collection("events").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error getting events: \(error.localizedDescription)")
                return
            }
            
            // Get all the events or return an empty array
            self.events = querySnapshot?.documents.compactMap { document in
                try? document.data(as: Event.self)
            } ?? []
            
        }
    }
}
