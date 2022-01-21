import SDWebImageSwiftUI
import SwiftUI

struct ContentView: View {
    
    let imageURL = "https://via.placeholder.com/155x250"
    
    @ObservedObject var model = ViewModel()
    
    var body: some View {
        List(model.events) { event in
            Text(event.title)
            
            Text(event.author.username)
        }
    }
    
    
    init() {
        model.getEvents()
    }
    
        
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/**
var body: some View {
    WebImage(url:URL(string: imageURL))
         .resizable()
         .placeholder {
           Rectangle().foregroundColor(.gray)
         }
       .indicator(.activity)
       .scaledToFit()
       .frame(width: 155.0, height:250.0)
}
 **/
