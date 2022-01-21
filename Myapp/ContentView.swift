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

