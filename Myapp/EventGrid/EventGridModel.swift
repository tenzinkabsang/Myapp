//
//  EventGridModel.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/8/22.
//

import Foundation
import SwiftUI

class EventGridModel: ObservableObject, Identifiable {
    
    @Published var events: [Event]
    
    init(events: [Event]) {
        self.events = events
    }
    
}
