import SwiftUI

struct CardRow: View {
    
    var events: [Event]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(alignment: .top, spacing: 0) {
                ForEach(events){ event in
                    CardItem(event: event)
                }
            }
        }
        .frame(height: 275)
    }
}

struct CardRow_Previews: PreviewProvider {
    static var previews: some View {
        CardRow(events: EventList.allEvents)
        
    }
}
