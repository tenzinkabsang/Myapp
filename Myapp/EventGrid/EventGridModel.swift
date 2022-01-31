//
//  EventGridModel.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/29/22.
//

import Foundation

class EventGridModel: ObservableObject, Identifiable {
    
    @Published var eventImageUrl: String
    @Published var title: String
    var id: String?
    
    init(event: Event) {
        self.id = event.id
        self.eventImageUrl = event.eventImageUrl
        self.title = event.category
    }
}
