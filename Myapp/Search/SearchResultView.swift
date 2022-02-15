//
//  SearchResultView.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/7/22.
//

import SwiftUI

struct SearchResultView: View {
    
    @ObservedObject var viewModel = SearchResultViewModel()
    
    var queryString: String
    
    init(queryString: String) {
        self.queryString = queryString
    }
    
    var body: some View {
        VStack(alignment: .center) {
            ScrollView(showsIndicators: false){
                
                Text("\(viewModel.eventGridModel.events.count) results")
                    .padding()
                    .font(.subheadline)
                
                EventGrid(eventGridModel: viewModel.eventGridModel, numberOfColumns: 2, gridItemHeight: 250)
            }
        }
        .task {
            await viewModel.search(queryString: queryString)
        }
        .navigationTitle(self.queryString)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(false)
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(queryString: "")
    }
}
