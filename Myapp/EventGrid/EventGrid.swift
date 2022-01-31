//
//  EventGrid.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/29/22.
//

import SwiftUI

struct EventGrid: View {
    
    var events: [Event]
    
    @State var gridLayout: [GridItem]
    
    init(events: [Event]) {
        self.events = events
        if (self.events.count % 2 != 0) {
            self.events.removeLast()
        }
        
        self.gridLayout = Array(repeating: GridItem(.flexible(), spacing: 2), count: 3)
    }
    
    var body: some View {
            
        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 2) {
            ForEach(events) { event in
                EventGridItem(event)
                    
            }
        }
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        
    }
}

struct EventGrid_Previews: PreviewProvider {
    static var previews: some View {
        EventGrid(events: [EventList.allEvents[0]])
    }
}
