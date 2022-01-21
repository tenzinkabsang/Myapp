import SwiftUI

struct CardItem: View {
    
    var event: Event
    
    var body: some View {
        ZStack{
            
            AsyncImage(url: URL(string: event.eventImageUrl + "q?w=155&h=250"))
                .frame(width: 155, height: 250)
                .cornerRadius(5)
            //.clipShape(RoundedRectangle(cornerRadius: 5))
            
            // TODO: Add distance info here
            
            
            VStack{
                Spacer()
                Text("#" + event.category.uppercased() + " " + event.title)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .padding(.all, 9)
            }
        }
        .frame(width: 155, height: 250)
        .padding(.leading, 15)
        
        
    }
    
}

struct CardItem_Previews: PreviewProvider {
    static var previews: some View {
        CardItem(event: EventList.allEvents[0])
    }
}
