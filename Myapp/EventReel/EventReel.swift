import SwiftUI

struct EventReel: View {
    
    var events: [Event]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(alignment: .top, spacing: 10) {
                ForEach(events){ event in
                    
                    NavigationLink {
                        let eventCardModel = EventCardModel(event: event)
                        EventDetail(eventCardModel: eventCardModel)
                    } label: {
                        EventReelItem(event)
                    }
                    .buttonStyle(FlatLinkStyle())
                }
            }
            .padding(.horizontal, 10)
        }
        .frame(height: 275)  // 275
    }
}

struct EventReel_Previews: PreviewProvider {
    static var previews: some View {
        EventReel(events: [EventList.allEvents[0]])
        
    }
}
