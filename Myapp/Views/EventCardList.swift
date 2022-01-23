import SwiftUI

struct EventCardList: View {
    
    var events: [Event]
    
    var body: some View {
        
        List(events) { event in
            EventCard(event: event)
                .listRowInsets(EdgeInsets())
        }
        .listRowSeparator(.hidden)
        //.listStyle(.inset)
    }
}

struct EventCardList_Previews: PreviewProvider {
    static var previews: some View {
        EventCardList(events: EventList.allEvents)
    }
}
