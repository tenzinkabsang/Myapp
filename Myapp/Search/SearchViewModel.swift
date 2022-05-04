//
//  SearchViewModel.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/7/22.
//

import Foundation
import Resolver
import Firebase
import Combine

class SearchViewModel: ObservableObject {
    @Injected var categoryRepository: ICategoryRepository
    @Injected var eventRepository: IEventRepository
    
    private let db = Firestore.firestore()
    
    @Published var categories = [Category]()
    @Published var eventGridModel = EventGridModel(events: [])
    
    @Published private var events = [Event]()
    private var cancellables = Set<AnyCancellable>()
    
//    init() {
//        $events
//            .sink {[weak self] events in
//                self?.eventGridModel = EventGridModel(events: events)
//            }
//            .store(in: &cancellables)
//    }
    
    @MainActor
    func loadInitialData() {
        Task {
            
            async let categoriesTask = categoryRepository.fetchAllCategoriesAsync()
            async let eventsTask = eventRepository.fetchEventsAsync()
            
            let(categories, events) = try await(categoriesTask, eventsTask)
            //search()
            
            self.categories = categories
            self.eventGridModel = EventGridModel(events: events)
        }
        
    }
    
    func search(searchText: String = "") {
        
        let eventsRef = db.collection("events")
        
        if !searchText.isEmpty {
            let query = eventsRef.whereField("category", isEqualTo: searchText)
            
            query.addSnapshotListener { querySnapshot, error in
                
                guard let querySnapshot = querySnapshot else {
                    print("Error getting event updates: \(error.debugDescription)")
                    return
                }
                
                self.events = querySnapshot.documents.compactMap{ document in
                    try? document.data(as: Event.self)
                }
            }
        } else {
            eventsRef
                .addSnapshotListener { querySnapshot, error in
                    
                    guard let querySnapshot = querySnapshot else {
                        print("Error getting event updates: \(error.debugDescription)")
                        return
                    }
                    
                    self.events = querySnapshot.documents.compactMap{ document in
                        try? document.data(as: Event.self)
                    }
                }
        }
    }
}

