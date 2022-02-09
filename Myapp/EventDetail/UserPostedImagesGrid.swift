//
//  EventGrid.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/29/22.
//

import SwiftUI

struct UserPostedImagesGrid: View {
    
    var eventGridItemModels: [EventGridItemModel]
    
    var gridLayout: [GridItem]
    private let gridItemHeight: CGFloat = 140
    
    init(_ models: [EventGridItemModel]) {
        self.eventGridItemModels = models
        self.gridLayout = Array(repeating: GridItem(.flexible(), spacing: 2), count: 3)
    }
    
    var body: some View {
            
        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 2) {
            ForEach(eventGridItemModels) { model in
                
                // TODO: Add image viewer
                NavigationLink {
                    ImageCarousel(imageUrl: model.eventImageUrl)
                } label: {
                    EventGridItem(model: model, gridItemHeight: self.gridItemHeight)
                }
                .buttonStyle(FlatLinkStyle())
            }
        }
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        
    }
}

struct UserPostedImagesGrid_Previews: PreviewProvider {
    static var previews: some View {
        UserPostedImagesGrid(EventList.eventGridModels)
    }
}
