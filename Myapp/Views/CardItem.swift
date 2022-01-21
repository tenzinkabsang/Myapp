import SwiftUI

struct CardItem: View {
    
    var event: Event

    var body: some View {
        ZStack{
            AsyncImage(url: URL(string: event.eventImageUrl))
        }
    }
}

struct CardItem_Previews: PreviewProvider {
    static var previews: some View {
        CardItem(event: EventList.allEvents[0])
    }
}
