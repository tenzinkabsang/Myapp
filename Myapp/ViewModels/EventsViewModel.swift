import Foundation
import FirebaseFirestore
import Resolver
import Combine

class EventsViewModel: ObservableObject {
    
    @Injected var eventRepository: IEventRepository
    @Injected var categoryRepository: ICategoryRepository
    
    @Published var eventReelData = [Event]()
    @Published var events = [Event]()
    @Published var categories = [Category]()
    
//   private var cancellables = Set<AnyCancellable>()
//
//    init() {
//        // Subscribe to repository tiles
//        eventRepository.$liveTilesEvents.map { tiles in
//            tiles.map { tile in
//                EventViewModel(event: tile)
//            }
//        }
//        .assign(to: &$liveTilesEvents)
//
//        // Subscribe to repository events
//        eventRepository.$events.map { events in
//            events.map { event in
//                FullEventViewModel(event: event)
//            }
//        }.assign(to: &$fullEventViewModels)
//
//    }
    
    @MainActor
    func loadItems() {
        Task {
            async let eventsTask = eventRepository.fetchEventsAsync()
            async let eventReelsTask = eventRepository.fetchEventReelsAsync()
            async let categoriesTask = categoryRepository.fetchAllCategoriesAsync()
            let (events, eventReels, categories) = try await(eventsTask, eventReelsTask, categoriesTask)
            
            self.events = events
            self.eventReelData = eventReels
            self.categories = categories
        }
    }
    
    
    func getCategories() -> [String] {
        var distinct = [String]()
        
        events.forEach { e in
            if !distinct.contains(e.category) {
                distinct.append(e.category)
            }
        }
        return distinct
    }
    
    func refreshData() {
        eventRepository.loadData()
    }
}


//    private var events = [Event]()
//
//    private let path: String = "events"
//
//    private var db = Firestore.firestore()

    
//    func getData() {
//        fetchLiveTilesData()
//        fetchEventsx()
//        fetchEventsWithUpdates()
//    }
//
//
//    func fetchLiveTilesData() {
//        db.collection(path).whereField("isExpired", isEqualTo: false).addSnapshotListener { querySnapshot, error in
//            if let error = error {
//                print("Error getting events: \(error.localizedDescription)")
//                return
//            }
//
//            if let querySnapshot = querySnapshot {
//                self.liveTilesEvents = querySnapshot.documents.compactMap { querySnapshot -> Event? in
//                    return try? querySnapshot.data(as: Event.self)
//                }
//            }
//        }
//    }
//
//    func fetchEventsx() {
//        db.collection(path).whereField("isExpired", isEqualTo: false).getDocuments { snapshot, error in
//            if let error = error {
//                print("Error getting events: \(error.localizedDescription)")
//                return
//            }
//
//            if let querySnapshot = snapshot {
//                self.events = querySnapshot.documents.compactMap{ d -> Event? in
//                    return try? d.data(as: Event.self)
//                }
//            }
//        }
//    }
//
//    func fetchEventsWithUpdates() {
//        self.events.forEach { event in
//            db.collection(path).document(event.id!).collection("eventUpdates").addSnapshotListener { querySnapshot, error in
//                if let error = error {
//                    print("Error getting events: \(error.localizedDescription)")
//                    return
//                }
//
//                if let querySnapshot = querySnapshot {
//                    let eventUpdates = querySnapshot.documents.compactMap { d -> EventUpdate? in
//                        return try? d.data(as: EventUpdate.self)
//                    }
//                    self.fullEventViewModels.append(FullEventViewModel(event: event, guests: eventUpdates))
//                } else {
//                    // No eventUpdates exits for this event
//                    self.fullEventViewModels.append(FullEventViewModel(event: event, guests: [EventUpdate]()))
//                }
//            }
//        }
//    }
//
//    func fetchEvents() {
//
//        db.collection("events").getDocuments { snapshot, error in
//            if let querySnapshot = snapshot {
//
//                var eventUpdates = [EventUpdate]()
//                for document in querySnapshot.documents {
//                    document.reference.collection("eventUpdates").getDocuments{ eventUpdateSnapshot, error in
//
//                        if let eventUpdateSnapshot = eventUpdateSnapshot {
//                            eventUpdates = eventUpdateSnapshot.documents.compactMap { ed -> EventUpdate? in
//                                return try? ed.data(as: EventUpdate.self)
//                            }
//                        }
//                    }
//                }
//
//                self.events = querySnapshot.documents.compactMap { d in
//
//
//                    let event = Event(id: d.documentID,
//                                      author: UserInfo(userId: d["author.userId"] as? String ?? "",
//                                                       username: d["author.username"] as? String ?? "",
//                                                       profileImageUrl: d["author.profileImageUrl"] as? String ?? ""),
//                                      category: d["category"] as? String ?? "",
//                                      eventImageUrl: d["eventImageUrl"] as? String ?? "",
//                                      isExpired: d["isExpired"] as? Bool ?? true,
//                                      title: d["title"] as? String ?? "",
//                                      location: Location(latitude: d["location.latitude"] as? String ?? "", longitude: d["location.longitude"] as? String ?? ""),
//                                      createdAt: d["createdAt"] as? Date ?? Date(),
//                                      eventUpdates: eventUpdates)
//
//                    return event
//
//                }
//            }
//        }
        
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
   // }
    
    
//    func fetchDataManual() {
//        db.collection("events").whereField("isExpired", isEqualTo: false).getDocuments { snapshot, error in
//            if let error = error {
//                print("Error getting events: \(error.localizedDescription)")
//                return
//            }
//
//            if let querySnapshot = snapshot {
//                // DispatchQueue.main.async {
//                self.events = querySnapshot.documents.compactMap{ d in
//                    let event = Event(id: d.documentID,
//                                      author: UserInfo(userId: d["author.userId"] as? String ?? "",
//                                                       username: d["author.username"] as? String ?? "",
//                                                       profileImageUrl: d["author.profileImageUrl"] as? String ?? ""),
//                                      category: d["category"] as? String ?? "",
//                                      eventImageUrl: d["eventImageUrl"] as? String ?? "",
//                                      isExpired: d["isExpired"] as? Bool ?? true,
//                                      title: d["title"] as? String ?? "",
//                                      location: Location(latitude: d["location.latitude"] as? String ?? "", longitude: d["location.longitude"] as? String ?? ""),
//                                      createdAt: d["createdAt"] as? Date ?? Date(),
//                                      eventUpdates: [EventUpdate]())
//
//                    return event
//                }
//                // }
//            }
//
//        }
//    }
//
//
//    func fetchDataManualx() {
//        db.collection("events").whereField("isExpired", isEqualTo: false).addSnapshotListener { querySnapshot, error in
//            if let error = error {
//                print("Error getting events: \(error.localizedDescription)")
//                return
//            }
//
//            if let querySnapshot = querySnapshot {
//                self.events = querySnapshot.documents.compactMap{ d in
//                    Event(id: d.documentID,
//                          author: UserInfo(userId: d["author.userId"] as? String ?? "",
//                                           username: d["author.username"] as? String ?? "",
//                                           profileImageUrl: d["author.profileImageUrl"] as? String ?? ""),
//                          category: d["category"] as? String ?? "",
//                          eventImageUrl: d["eventImageUrl"] as? String ?? "",
//                          isExpired: d["isExpired"] as? Bool ?? true,
//                          title: d["title"] as? String ?? "",
//                          location: Location(latitude: d["location.latitude"] as? String ?? "", longitude: d["location.longitude"] as? String ?? ""),
//                          createdAt: d["createdAt"] as? Date ?? Date(),
//                          eventUpdates: [EventUpdate]())
//                }
//            }
//
//        }
//    }
//
//    func fetchData() {
//        db.collection("events").addSnapshotListener { querySnapshot, error in
//            if let error = error {
//                print("Error getting events: \(error.localizedDescription)")
//                return
//            }
//
//            // Get all the events or return an empty array
//            self.events = querySnapshot?.documents.compactMap { document in
//                try? document.data(as: Event.self)
//            } ?? []
//
//        }
//    }
//}
