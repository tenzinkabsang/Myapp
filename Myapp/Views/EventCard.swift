
import SwiftUI

struct EventCard: View {
    @ObservedObject var model: EventCardModel
    var cardHeight: CGFloat
    
    private var bottomSpace: CGFloat = 15.0
    
    
    @State var showCommentsIcon = true
        
    init(eventCardModel: EventCardModel, cardHeight: CGFloat = 450){
        
        // Add whitespace at bottom of card
        self.cardHeight = cardHeight + bottomSpace
        
        
        self.model = eventCardModel
        self.model.loadEventInfo()
    }
    
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            EventImageView(eventUrl: model.eventImageUrl, cornerRadius: 0,  height: self.cardHeight)
            
            HStack(alignment: .bottom, spacing: 5) {
                VStack(alignment: .leading, spacing: 5) {
                    distanceInfo
                    profileImageAndText
                }
                
                if showCommentsIcon {
                    VStack(alignment: .center, spacing: 5) {
                        Button {
                            // Show comments
                        } label: {
                            Image(systemName: "text.bubble")
                                .font(.system(size: 40, weight: .ultraLight))
                                .foregroundColor(.black)
                            
                        }
                        
                        Button {
                            // Show comments
                        } label: {
                            Image(systemName: "heart")
                                .font(.system(size: 40, weight: .ultraLight))
                                .foregroundColor(.black)
                            
                        }
                        .padding(.bottom, 10)
                        
                    }
                }
            }
            .padding(.vertical, 9)
            .padding(.horizontal, 5)
        }
        .frame(height: cardHeight)
        .padding(.bottom, bottomSpace)
        .overlay(
            Rectangle()
                .frame(height: bottomSpace)
                .foregroundColor(.white),
            alignment: .bottom
        )
    }
    
    
    @ViewBuilder var distanceInfo: some View {
        HStack {
             Spacer()
            Text("1.6 Miles " + model.numberOfGuests)
                .padding(5)
                .background(.gray)
                .font(.subheadline)
                .foregroundColor(.white)
                .opacity(0.8)
            
            Spacer()
        }
        .padding(.bottom, 5)
    }
    
    @ViewBuilder var profileImageAndText: some View {
        HStack(alignment: .center) {
            CardProfileImage(imageUrl: model.profileImageUrl)
                .padding(.leading, 5)
            
            Text(model.eventTitle)
            //.fontWeight(.bold)
                .lineLimit(2)
        }
        .font(.subheadline)
        .foregroundColor(.white)
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        EventCard(eventCardModel: EventCardModel(event: EventList.allEvents[0]))
    }
}
