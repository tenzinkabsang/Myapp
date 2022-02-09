import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = EventsViewModel()
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView{
            List {
                
                CategoryBadgeReel(categories: viewModel.categories).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                
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
            .searchable(text: $searchText){
                ForEach(viewModel.getCategories(), id:\.self) { category in
                    Text(category).searchCompletion(category)
                }
            }
            .onSubmit(of: .search) {
                print(searchText)
            }
            
            .listStyle(.inset)
            
            .navigationTitle("New")
            .toolbar {
                Button {
                    // TODO: bring focus to searchbar
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20, weight: .ultraLight))
                        .foregroundColor(.black)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    
    init() {
        self.viewModel.loadItems()
    }
    
    
    //                CategoryBadgeReel(categories: viewModel.getCategories()).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
    //
    
    //EventGrid(events: viewModel.eventReelData)
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
