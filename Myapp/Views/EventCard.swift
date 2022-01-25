
import SwiftUI

struct EventCard: View {
    var event: Event
    
    var body: some View {
        let cardHeight: Double = 400
        
        ZStack {
            LiveEventView(eventUrl: event.eventImageUrl, cornerRadius: 0,  height: cardHeight)
            VStack(alignment: .leading) {
                Spacer()
                
                Group {
                    HStack {
                        
                        CardProfileImage(imageUrl: event.author.profileImageUrl)
                        
                        Text("#" + event.category.uppercased() + " " + event.title)
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
        EventCard(event: EventList.allEvents[0])
    }
}
