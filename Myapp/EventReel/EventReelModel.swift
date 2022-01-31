//
//  EventReelViewModel.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/28/22.
//

import Foundation

class EventReelModel: ObservableObject, Identifiable {
    
    @Published var eventImageUrl: String
    @Published var eventTitle: String
    var id: String?
        
    init(event: Event) {
        self.id = event.id
        
        self.eventImageUrl = event.eventImageUrl
        self.eventTitle = EventReelModel.getEventTitle(event)
        
    }
    
    static func getEventTitle(_ event: Event) -> String {
        return  "#" + event.category.uppercased() + " " + event.title
    }
}
