//
//  SearchView.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/7/22.
//

import SwiftUI

struct SearchViewY: View {
    
    @Environment(\.dismissSearch) var dismissSearch
    
    @ObservedObject var viewModel = SearchViewModel()
    
    @State private var searchText = ""
    
    
    @State private var queryString = ""
    @State private var startSearch = false
    
    init() {
        self.viewModel.loadInitialData()
    }
    
    var body: some View {
        NavigationView {
            
            ScrollView(showsIndicators: false) {
                CategoryBadgeReel(categories: viewModel.categories, queryString: $queryString, startSearch: $startSearch)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .padding(.vertical, 3)
                
                EventGrid(eventGridModel: viewModel.eventGridModel, numberOfColumns: 2, gridItemHeight: 250)
                
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always)){
                if searchText.isEmpty {
                ForEach(viewModel.categories) { category in
                    Text(category.name).searchCompletion(category.name)
                }
                }
            }
            .onSubmit(of: .search) {
                print(searchText)
                if !searchText.isEmpty {
                    viewModel.search(searchText: searchText)
                }
            }
            .listStyle(.inset)
            .navigationTitle("Discover")
            .navigationBarTitleDisplayMode(.inline)
            
            
        }
    }
}

struct SearchViewY_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewY()
    }
}
