
import SwiftUI

struct EventCardXX: View {
    @ObservedObject var model: EventCardModel
    var cardHeight: CGFloat
    
    init(eventCardModel: EventCardModel, cardHeight: CGFloat = 450){
        self.cardHeight = cardHeight
        self.model = eventCardModel
        self.model.loadEventInfo()
    }
    
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            EventImageView(eventUrl: model.eventImageUrl, cornerRadius: 0,  height: self.cardHeight)
            
            VStack(alignment: .leading) {
                
                HStack {
                    Spacer()
                   CardProfileImage(imageUrl: model.profileImageUrl)
                
                }
                
                HStack {
                    Spacer()
                    Text("1.4 Miles")
                        .padding(5)
                        .background(.gray)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .opacity(0.8)
                    
                    
                    Text(model.numberOfGuests)
                    Spacer()
                }
                
                VStack(alignment: .leading) {
                    Text("@tenzinkabsang")
                    
                    Text(model.eventTitle)
                        //.fontWeight(.bold)
                        .lineLimit(2)
                }
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.all, 9)
                
            }
        }
        
                
//        ZStack {
//            EventImageView(eventUrl: model.eventImageUrl, cornerRadius: 0,  height: self.cardHeight)
//            VStack(alignment: .leading) {
//                Spacer()
//
//                Group {
//                    HStack {
//
//                        CardProfileImage(imageUrl: model.profileImageUrl)
//
//                        Text(model.eventTitle)
//                            .font(.subheadline)
//                            .foregroundColor(.white)
//                            .fontWeight(.bold)
//                            .padding(.all, 9)
//                            .lineLimit(2)
//                    }
//                    .offset(y: 20)
//
//                    // TODO: Figure this out, possibly use firestore subscriptions to dynamically calculate
//                    HStack {
//                        Text("1.4 Miles")
//
//
//                        Text(model.numberOfGuests)
//
//                        Spacer()
//
//                        Spacer()
//                    }
//
//                }
//                .padding(.all, 8.0)
//
//            }
//        }
        .frame(height: cardHeight)
       // .padding([.bottom, .top], 10)
    }
}

struct EventCardXX_Previews: PreviewProvider {
    static var previews: some View {
        EventCard(eventCardModel: EventCardModel(event: EventList.allEvents[0]))
    }
}
