import SwiftUI

struct EventReelItem: View {
    
    var event: Event
    
    private let width: Double = 155
    private let height: Double = 250
    
    var body: some View {
        ZStack{
            
            LiveEventView(eventUrl: event.eventImageUrl, width: width, height: height)
            
            // TODO: Add distance info here
            
            
            VStack(alignment: .leading){
                Spacer()
                Text("#" + event.category.uppercased() + " " + event.title)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.all, 9)
                    .lineLimit(2)
            }
        }
        .frame(width: width, height: height)
        .padding(.leading, 15)
        
        
    }
    
}

struct EventReelItem_Previews: PreviewProvider {
    static var previews: some View {
        EventReelItem(event: EventList.allEvents[0])
    }
}
