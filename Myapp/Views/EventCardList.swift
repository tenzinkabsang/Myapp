import SwiftUI

struct EventCardList: View {
    
    var events: [FullEventViewModel]
    
    var body: some View {
        
        List(events) { event in
            EventCard(model: event)
                .listRowInsets(EdgeInsets())
        }
        .listRowSeparator(.hidden)
        //.listStyle(.inset)
    }
}

struct EventCardList_Previews: PreviewProvider {
    static var previews: some View {
        EventCardList(events: EventList.fullEventModel)
    }
}
