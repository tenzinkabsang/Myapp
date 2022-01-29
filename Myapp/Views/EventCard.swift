
import SwiftUI

struct EventCard: View {
    @ObservedObject var model: EventCardModel
    
    init(_ event: Event){
        self.model = EventCardModel(event: event)
        //self.model.loadData()
        //self.model.loadEventInfo()
        
        self.model.loadEventInfo()
        
    }
    
    
    var body: some View {
        let cardHeight: Double = 450
        
        ZStack {
            LiveEventView(eventUrl: model.eventImageUrl, cornerRadius: 0,  height: cardHeight)
            VStack(alignment: .leading) {
                Spacer()
                
                Group {
                    HStack {
                        
                        CardProfileImage(imageUrl: model.profileImageUrl)
                        
                        Text(model.eventTitle)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.all, 9)
                            .lineLimit(2)
                    }
                    .offset(y: 20)
                    
                    // TODO: Figure this out, possibly use firestore subscriptions to dynamically calculate
                    HStack {
                        Text("1.4 Miles")
                        
                        
                        Text(model.numberOfGuests)
                        
                        Spacer()
//                        if !event.eventUpdates?.isEmpty! {
//                            Text(event.eventUpdates[0].guest.username)
//                        } else {
//                            Text("event update is empty")
//                        }
                        
                        Spacer()
                    }
                    
                }
                .padding(.all, 8.0)
                
            }
        }
        .frame(height: cardHeight)
        .padding([.bottom, .top], 10)
        
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        EventCard(EventList.allEvents[0])
    }
}
