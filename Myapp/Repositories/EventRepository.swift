import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine


class EventRepository: ObservableObject {
    private let path: String = "events"
    
    private let store = Firestore.firestore()
    
    func add(_ event: Event) {
        do {
            _ = try store.collection(path).addDocument(from: event)
        } catch {
            fatalError("Unable to create event!")
        }
    }
}

