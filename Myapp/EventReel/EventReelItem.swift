import SwiftUI

struct EventReelItem: View {
    
    @ObservedObject var model: EventReelModel
    
    private let width: Double = 165   // 155 350
    private let height: Double = 250 // 240
    
    
    init(_ event: Event){
        self.model = EventReelModel(event: event)
    }
    
    
    var body: some View {
        ZStack{
            
            EventImageView(eventUrl: model.eventImageUrl, cornerRadius: 5, width: width, height: height)
            
            // TODO: Add distance info here
            
            
            VStack(alignment: .center){
                Spacer()
                
                
                Text(model.eventTitle)
                    .font(.caption)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.all, 9)
                    .lineLimit(2)
            }
        }
        .frame(width: width, height: height)
        //.padding(.leading, 5)
    }
   
}

struct EventReelItem_Previews: PreviewProvider {
    static var previews: some View {
        EventReelItem(EventList.allEvents[0])
    }
}
