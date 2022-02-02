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
    
    init(id: String?, imageUrl: String, title: String) {
        self.id = id
        self.eventImageUrl = imageUrl
        self.title = title
    }
}
