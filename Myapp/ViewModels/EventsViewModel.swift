import Foundation
import FirebaseFirestore

class EventsViewModel: ObservableObject {
    @Published var events = [Event]()
    
    private var db = Firestore.firestore()
    
    func fetchDataNormal() {
        db.collection("events").getDocuments { snapshot, error in
            
            if let snapshot = snapshot {
                self.events = snapshot.documents.compactMap { document -> Event? in
                    return try? document.data(as: Event.self)
                }
            }
        }
    }
    
    func fetchDataManualX() {
        db.collection("events").whereField("isExpired", isEqualTo: false).getDocuments { snapshot, error in
            if let error = error {
                print("Error getting events: \(error.localizedDescription)")
                return
            }
            
            if let querySnapshot = snapshot {
               // DispatchQueue.main.async {
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
                              startTime: d["startTime"] as? Date ?? Date(),
                              eventUpdates: [EventUpdate]())
                    }
               // }
            }
            
        }
    }
    
    func fetchDataManual() {
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
                          startTime: d["startTime"] as? Date ?? Date(),
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
