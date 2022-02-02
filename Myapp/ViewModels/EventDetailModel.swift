//
//  EventDetailModel.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/31/22.
//

import Foundation
import Resolver
import Firebase
import Combine

import FirebaseFirestoreSwift

class EventDetailModel: ObservableObject {
    @Injected var eventRepository: IEventRepository
    
    @Published var eventUpdates = [EventUpdate]()
    
    @Published var eventCardModel: EventCardModel
    
    @Published var eventGridModels = [EventGridModel]()
    
    
    private let db = Firestore.firestore()
    
    var id: String?
    
    init(_ eventCardModel: EventCardModel){
        self.id = eventCardModel.id
        self.eventCardModel = eventCardModel
        
        $eventUpdates
            .map { eventUpdates in
                eventUpdates.flatMap { eventUpdate in
                    eventUpdate.images
                }
                .sorted(by: { first, second in
                    first.createdAt! > second.createdAt!
                })
                .map { userImage in
                    EventGridModel(id: UUID().uuidString, imageUrl: userImage.imageUrl, title: userImage.profileImageUrl)
                    
                }
            }
            .assign(to: &$eventGridModels)
        
    }
    
    
    func loadEventUpdates() {
        db.collection("events").document(self.id!).collection("eventUpdates")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting event updates: \(error.localizedDescription)")
                    return
                }
                
                if let querySnapshot = querySnapshot {
                    self.eventUpdates = querySnapshot.documents.compactMap{ document in
                        try? document.data(as: EventUpdate.self)
                    }
                }
            }
    }
}
