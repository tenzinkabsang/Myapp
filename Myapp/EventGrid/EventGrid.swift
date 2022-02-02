//
//  EventGrid.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/29/22.
//

import SwiftUI

struct EventGrid: View {
    
    var eventGridModels: [EventGridModel]
    
    @State var gridLayout: [GridItem]
    
    init(_ models: [EventGridModel]) {
        self.eventGridModels = models
        self.gridLayout = Array(repeating: GridItem(.flexible(), spacing: 2), count: 3)
    }
    
    var body: some View {
            
        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 2) {
            ForEach(eventGridModels) { model in
                EventGridItem(model)
                    
            }
        }
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        
    }
}

struct EventGrid_Previews: PreviewProvider {
    static var previews: some View {
        EventGrid(EventList.eventGridModels)
    }
}
