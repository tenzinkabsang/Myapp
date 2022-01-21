import Foundation
import Firebase
import SwiftUI

final class ViewModel: ObservableObject {
    @Published var events = [Event]()
    
    func getEvents() {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        
        // Read the documents at a specific path
        db.collection("events").getDocuments { snapshot, error in
            // Check for errors
            if error == nil {
                
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        self.events = snapshot.documents.map { d in
                            return Event(id: d.documentID,
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
            } else {
                // Handle error
            }
        }
    }
}
