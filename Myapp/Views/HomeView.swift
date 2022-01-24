import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = EventsViewModel()
    
    
    var body: some View {
        NavigationView{
            
            List {
                
                CategoryBadgeReel(events: viewModel.events).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                
                EventReel(events: viewModel.events).listRowInsets(EdgeInsets())
                
                ForEach(viewModel.events) { event in EventCard(event: event) }.listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
               
            }
            .refreshable {
                self.viewModel.fetchDataManual()
            }
            .listStyle(.inset)
            .navigationTitle("New")
        }
    }
    
    init() {
        self.viewModel.fetchDataManual()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
