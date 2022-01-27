import SwiftUI

struct EventReel: View {
    
    var events: [EventViewModel]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(alignment: .top, spacing: 0) {
                ForEach(events){ event in
                    EventReelItem(model: event)
                }
            }
        }
        .frame(height: 275)
    }
}

struct EventReel_Previews: PreviewProvider {
    static var previews: some View {
        EventReel(events: EventList.eventModels)
        
    }
}
