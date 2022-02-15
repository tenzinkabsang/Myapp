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
    @Binding var startSearch: Bool
       
    private func closeSearch() {
        withAnimation {
            queryString = ""
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
                    Image(systemName: "magnifyingglass").font(.system(size: 20, weight: .light)).foregroundColor(.gray)
                    
                    TextField("Search", text: $queryString) { startedEditing in
                        if startedEditing {
                            withAnimation {
                                isSearching = true
                            }
                        }
                    } onCommit: {
                        withAnimation {
                            guard !queryString.isEmpty else { return }
                            
                            //queryString = ""
                            startSearch = true
                        }
                    }
                    .submitLabel(.search)
                                        
                    if !queryString.isEmpty {
                        Button {
                           queryString = ""
                        } label: {
                            Image(systemName: "xmark").font(.system(size: 20, weight: .light)).foregroundColor(.gray)
                        }
                        .padding(.trailing, 15)
                    }
                }
                .padding(.leading, 13)
            }
            .frame(height: 40)
            .cornerRadius(13)
            .padding()
            
            if isSearching {
                Button { closeSearch() } label: { Text("Close").padding(.trailing, 10).padding(.leading, -10) }
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var query = ""
    @State static var searching = true
    static var previews: some View {
        SearchBar(queryString: $query, isSearching: $searching, startSearch: $searching)
    }
}

