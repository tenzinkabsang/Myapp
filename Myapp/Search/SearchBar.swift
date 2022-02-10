//
//  SearchBar.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/7/22.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var queryString: String
    @Binding var isSearching: Bool
    
    var performSearch: ((_ searchText: String) -> Void)
    
    func closeSearch() {
        queryString = ""
        //performSearch("")
        withAnimation {
            isSearching = false
            UIApplication.shared.dismissKeyboard()
        }
    }
    
    var body: some View {
        
        HStack {
            ZStack {
                Rectangle()
                    .foregroundColor(Color("LightGray"))
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $queryString) { startedEditing in
                        if startedEditing {
                            withAnimation {
                                isSearching = true
                            }
                        }
                    } onCommit: {
                        withAnimation {
                            isSearching = false
                            performSearch(queryString)
                           
                        }
                    }
                    .submitLabel(.search)
                    
                    if !queryString.isEmpty {
                        Button {
                            closeSearch()
                        } label: {
                            Image(systemName: "xmark")
                        }
                        .padding(.trailing, 15)
                    }
                }
                .foregroundColor(.gray)
                .padding(.leading, 13)
            }
            .frame(height: 40)
            .cornerRadius(13)
            .padding()
            
            if isSearching {
                Button {
                   closeSearch()
                } label: {
                    Text("Close")
                        .padding(.trailing, 10)
                        .padding(.leading, -10)
                }
                
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var query = ""
    @State static var searching = true
    static var previews: some View {
        SearchBar(queryString: $query, isSearching: $searching) { searchText in
            print(searchText)
        }
    }
}
