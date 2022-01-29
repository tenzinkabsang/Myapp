import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = EventsViewModel()
        
    var body: some View {
        NavigationView{
            VStack(alignment: .leading, spacing: 0) {
            NavView()
            List {
                
                CategoryBadgeReel(categories: viewModel.getCategories()).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                
                EventReel(events: viewModel.eventReelData)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
            
                ForEach(viewModel.events) { event in
                    EventCard(event)
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
               
            }
            .refreshable {
                self.viewModel.loadItems()
            }
            .listStyle(.inset)
            .navigationTitle("New")
            .navigationBarHidden(true)
            }
        }
    }
        
    
    init() {
        //self.viewModel.fetchDataManual()
       // self.viewModel.fetchEvents()
        self.viewModel.loadItems()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
