//
//  EventGridItem.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/29/22.
//

import SwiftUI

struct EventGridItem: View {
    
    @ObservedObject var model: EventGridModel
    
    private var width: CGFloat = .infinity
    private var height: CGFloat = 140
    
    init(_ model: EventGridModel) {
        self.model = model
    }
    
    
    var body: some View {
        ZStack {
            
            EventImageView(eventUrl: model.eventImageUrl, cornerRadius: 0, width: self.width, height: self.height)
            
            VStack(alignment: .leading) {
                Spacer()
                Text(model.title)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.all, 9)
                    .lineLimit(2)
                
            }
            .frame(height: self.height)
            
        }
    }
}

struct EventGridItem_Previews: PreviewProvider {
    static var previews: some View {
        EventGridItem(EventList.eventGridModels[0])
    }
}
