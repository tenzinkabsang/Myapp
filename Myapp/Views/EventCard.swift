
import SwiftUI

struct EventCard: View {
    @ObservedObject var model: EventCardModel
    var cardHeight: CGFloat
    
    init(eventCardModel: EventCardModel, cardHeight: CGFloat = 450){
        self.cardHeight = cardHeight
        self.model = eventCardModel
        self.model.loadEventInfo()
    }
    
    
    var body: some View {
                
        ZStack {
            EventImageView(eventUrl: model.eventImageUrl, cornerRadius: 0,  height: self.cardHeight)
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
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        EventCard(eventCardModel: EventCardModel(event: EventList.allEvents[0]))
    }
}
