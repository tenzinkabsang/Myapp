//
//  EventGridItem.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/29/22.
//

import SwiftUI

struct EventGridItem: View {
    
    @ObservedObject var model: EventGridItemModel
    
    private var width: CGFloat = .infinity
    private var gridItemHeight: CGFloat
    
    init(model: EventGridItemModel, gridItemHeight: CGFloat) {
        self.model = model
        self.gridItemHeight = gridItemHeight
    }
    
    
    var body: some View {
        ZStack {
            
            EventImageView(eventUrl: model.eventImageUrl, cornerRadius: 0, width: self.width, height: self.gridItemHeight)
            
            VStack(alignment: .leading) {
                Spacer()
                Text(model.title)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.all, 9)
                    .lineLimit(2)
                
            }
            .frame(height: self.gridItemHeight)
            
        }
    }
}

struct EventGridItem_Previews: PreviewProvider {
    static var previews: some View {
        EventGridItem(model: EventList.eventGridModels[0], gridItemHeight: 140)
    }
}
