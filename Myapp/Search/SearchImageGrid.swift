//
//  SearchImageGrid.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/7/22.
//

import SwiftUI

struct SearchImageGrid: View {
    
    var events: [Event]
    
    @State var gridLayout: [GridItem]
    
    init(_ events: [Event]) {
        self.events = events
        self.gridLayout = Array(repeating: GridItem(.flexible(), spacing: 2), count: 3)
    }
    
    var body: some View {
        
        
        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 2) {
            ForEach(events) { event in
                
                NavigationLink {
                    let eventCardModel = EventCardModel(event: event)
                    EventDetail(eventCardModel: eventCardModel)
                } label: {
                    let eventGridModel = EventGridItemModel(id: event.id, imageUrl: event.eventImageUrl, title: event.title)
                    EventGridItem(model: eventGridModel, gridItemHeight: 200)
                }
                .buttonStyle(FlatLinkStyle())
            }
        }
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
    }
}

struct SearchImageGrid_Previews: PreviewProvider {
    static var previews: some View {
        SearchImageGrid(EventList.allEvents)
    }
}
