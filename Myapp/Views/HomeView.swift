import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = EventsViewModel()
        
    var body: some View {
        NavigationView{
            
            List {
                
                CategoryBadgeReel(categories: viewModel.getCategories()).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                
                EventReel(events: viewModel.liveTilesEvents).listRowInsets(EdgeInsets())
            
                ForEach(viewModel.fullEventViewModels) { event in
                    EventCard(model: event)
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
               
            }
            .refreshable {
                self.viewModel.refreshData()
            }
            .listStyle(.inset)
            .navigationTitle("New")
        }
    }
    
    init() {
        //self.viewModel.fetchDataManual()
       // self.viewModel.fetchEvents()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
