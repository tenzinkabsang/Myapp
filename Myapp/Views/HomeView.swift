import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = EventsViewModel()
    
    init() {
        self.viewModel.loadItems()
    }
    
    var body: some View {
        NavigationView{
            List {
                EventReel(events: viewModel.eventReelData)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                
                ForEach(viewModel.events) { event in
                    let cardModel = EventCardModel(event: event)
                    
                    ZStack {
                        EventCard(eventCardModel: cardModel)
                        
                        NavigationLink {
                            EventDetail(eventCardModel: cardModel)
                        } label: {
                            EmptyView()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            }
            .onAppear{
                UITableView.appearance().showsVerticalScrollIndicator = false
            }
            .refreshable {
                self.viewModel.loadItems()
            }
            .listStyle(.inset)
            .navigationTitle("New")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
