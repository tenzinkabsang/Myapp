//
//  SearchViewXX.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/8/22.
//

import SwiftUI

struct SearchViewXX: View {
    @ObservedObject var viewModel = SearchViewModel()
    
    
    @State private var queryString = ""
    @State private var isSearching = false
    
    
    init() {
        self.viewModel.loadInitialData()
    }
    
    func performSearch() {
        withAnimation {
            isSearching = false
            UIApplication.shared.dismissKeyboard()
        }
        
        viewModel.search(searchText: queryString)
    }
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading) {
                
                SearchBar(queryString: $queryString, isSearching: $isSearching) { searchText in
                    viewModel.search(searchText: searchText)
                }
                
                if isSearching {
                    List {
                        ForEach(viewModel.categories) { category in
                            Button {
                                queryString = category.name
                                performSearch()
                            } label: {
                                Text(category.name)
                            }

                        }
                        
                    }
                    .gesture(DragGesture().onChanged({ _ in UIApplication.shared.dismissKeyboard() }))
                    .listStyle(.inset)
                    
                } else {
                    ScrollView(showsIndicators: false) {
                        CategoryBadgeReel(categories: viewModel.categories).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                        
                        EventGrid(eventGridModel: viewModel.eventGridModel, numberOfColumns: 2, gridItemHeight: 250)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct SearchViewXX_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewXX()
    }
}
