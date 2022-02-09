//
//  EventDetail.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/31/22.
//

import SwiftUI

struct EventDetail: View {
    @ObservedObject var model: EventDetailModel
    
    init(eventCardModel: EventCardModel) {
        self.model = EventDetailModel(eventCardModel)
        self.model.loadEventUpdates()
    }
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack {
                EventCard(eventCardModel: model.eventCardModel, cardHeight: 550)
                    .padding(.bottom, 5.0)
                UserPostedImagesGrid(model.eventGridItemModels)
            }
            
        }
        .ignoresSafeArea()
    }
}

struct EventDetail_Previews: PreviewProvider {
    static var previews: some View {
        EventDetail(eventCardModel: EventCardModel(event: EventList.allEvents[0]))
    }
}
