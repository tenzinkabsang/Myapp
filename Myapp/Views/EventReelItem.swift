import SwiftUI

struct EventReelItem: View {
    
    @ObservedObject var model: EventViewModel
    
    private let width: Double = 155
    private let height: Double = 250
    
    var body: some View {
        ZStack{
            
            LiveEventView(eventUrl: model.event.eventImageUrl, width: width, height: height)
            
            // TODO: Add distance info here
            
            
            VStack(alignment: .leading){
                Spacer()
                Text(model.getEventTitle())
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
        EventReelItem(model: EventList.eventModels[0])
    }
}
