//
//  2ColumnGrid.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/8/22.
//

import SwiftUI

struct EventGrid: View {
    @ObservedObject var eventGridModel: EventGridModel
    
    private var gridLayout: [GridItem]
    private var gridItemHeight: CGFloat
    
    init(eventGridModel: EventGridModel, numberOfColumns: Int, gridItemHeight: CGFloat) {
        self.eventGridModel = eventGridModel
        self.gridLayout = Array(repeating: GridItem(.flexible(), spacing: 2), count: numberOfColumns)
        self.gridItemHeight = gridItemHeight
    }
    
    var body: some View {
        
        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 2) {
            ForEach(eventGridModel.events) { event in
                
                NavigationLink {
                    let eventCardModel = EventCardModel(event: event)
                    EventDetail(eventCardModel: eventCardModel)
                } label: {
                    let eventGridModel = EventGridItemModel(id: event.id, imageUrl: event.eventImageUrl, title: event.title)
                    EventGridItem(model: eventGridModel, gridItemHeight: self.gridItemHeight)
                }
                .buttonStyle(FlatLinkStyle())
            }
        }
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
    }
}

struct EventGrid_Previews: PreviewProvider {
    static var previews: some View {
        EventGrid(eventGridModel: EventGridModel(events: EventList.allEvents), numberOfColumns: 2, gridItemHeight: 200)
    }
}
