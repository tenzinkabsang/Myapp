//
//  FullEventViewModel.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/25/22.
//

import Foundation
import Combine

class FullEventViewModel: ObservableObject, Identifiable {
    var id: String?
    @Published var event: Event
    
    @Published var numberOfGuests: String
    
    @Published var guestName: String
    
    private var cancellables = Set<AnyCancellable>()
    
    init(event: Event) {
        self.event = event
       // id = event.id
        self.numberOfGuests = FullEventViewModel.getNumberOfGuests(event.eventUpdates ?? [])
        
        self.guestName = event.eventUpdates?[0].guest.username ?? "no name"
        
        $event
            .map { $0.id }
            .weakAssign(to: \.id, on: self)
            .store(in: &cancellables)
    }
    
    func getEventTitle() -> String {
        let count = self.event.eventUpdates?[0].guest.username ?? "no name"
        return  "#" + self.event.category.uppercased() + " " + self.event.title + " \(count)"
    }
    
    private static func getNumberOfGuests(_ eventUpdates: [EventUpdate]) -> String {
        let number = eventUpdates.count
        
        return "\(number) going"
    }
}

