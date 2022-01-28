import SwiftUI

struct EventReelItem: View {
    
    @ObservedObject var model: EventReelModel
    
    private let width: Double = 155
    private let height: Double = 250
    
    var body: some View {
        ZStack{
            
            LiveEventView(eventUrl: model.eventImageUrl, width: width, height: height)
            
            // TODO: Add distance info here
            
            
            VStack(alignment: .leading){
                Spacer()
                Text(model.eventTitle)
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
    
    init(_ event: Event){
        self.model = EventReelModel(event: event)
    }
    
}

struct EventReelItem_Previews: PreviewProvider {
    static var previews: some View {
        EventReelItem(EventList.allEvents[0])
    }
}
