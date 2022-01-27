//
//  EventViewModel.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/25/22.
//

import Foundation
import Combine

class EventViewModel: ObservableObject, Identifiable {
    var id: String?
    
    @Published var event: Event
    
    private var cancellables = Set<AnyCancellable>()
    
    init(event: Event) {
        self.event = event
        
        
        $event
            .map { $0.id }
            .weakAssign(to: \.id, on: self)
            .store(in: &cancellables)
    }
    
    func getEventTitle() -> String {
        return  "#" + self.event.category.uppercased() + " " + self.event.title
    }
}
