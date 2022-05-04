//
//  SearchViewXX.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/8/22.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = SearchViewModel()
    
    
    @State private var queryString = ""
    @State private var isSearching = false
    @State private var startSearch = false
    
    
    init() {
        self.viewModel.loadInitialData()
    }
        
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading) {
                
                SearchBar(queryString: $queryString, isSearching: $isSearching, startSearch: $startSearch)
                
                // Hidden: This is one that actually handles the navigation
                NavigationLink(isActive: $startSearch) { SearchResultView(queryString: queryString) } label: { EmptyView() }.hidden()

                if isSearching {
                    List {
                        ForEach(viewModel.categories) { category in
                            HStack {
                                Button {
                                    queryString = category.name
                                    startSearch = true
                                } label: {
                                    Text(category.name)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right").font(.system(size: 15, weight: .light)).foregroundColor(.black)
                            }
                        }
                    }
                    .gesture(DragGesture().onChanged({ _ in UIApplication.shared.dismissKeyboard() }))
                    .listStyle(.inset)
                } else {
                    ScrollView(showsIndicators: false) {
                        CategoryBadgeReel(categories: viewModel.categories, queryString: $queryString, startSearch: $startSearch)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                        
                        EventGrid(eventGridModel: viewModel.eventGridModel, numberOfColumns: 2, gridItemHeight: 250)
                    }
                }
            }
            .onAppear {
                queryString = ""
            }
            .navigationBarHidden(true)
        }
    }
        
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
