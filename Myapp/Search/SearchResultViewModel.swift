//
//  SearchResultViewModel.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/10/22.
//

import Foundation
import Resolver
import Firebase
import Combine

class SearchResultViewModel: ObservableObject {
    @Injected private var eventRepository: IEventRepository
    
    @Published var eventGridModel = EventGridModel(events: [])
        
    @MainActor
    func search(queryString: String) async {        
        do {
            let events = try await eventRepository.fetchEventsAsync()
            self.eventGridModel = EventGridModel(events: events)
        } catch {
            print("search error")
        }
    }
}
