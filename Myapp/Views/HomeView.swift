import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = EventsViewModel()
        
    var body: some View {
        NavigationView{
            VStack(alignment: .leading, spacing: 0) {
            //NavView()
            List {
                
//                CategoryBadgeReel(categories: viewModel.getCategories()).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
//
                EventReel(events: viewModel.eventReelData)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                
                //EventGrid(events: viewModel.eventReelData)
            
                ForEach(viewModel.events) { event in
                    let cardModel = EventCardModel(event: event)
                    
                    ZStack {
                        NavigationLink(
                            destination: EventDetail(eventCardModel: cardModel)){
                                EmptyView()
                            }
                            .opacity(0)
                        EventCard(eventCardModel: cardModel)
                            .padding([.bottom, .top], 10)
                    }
                    
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
               
            }
            .refreshable {
                self.viewModel.loadItems()
            }
            .listStyle(.inset)
            .navigationTitle("New")
            .navigationBarTitleDisplayMode(.inline)
            //.navigationBarHidden(true)
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
