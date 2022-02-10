//
//  CategoryBadge.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/23/22.
//

import SwiftUI


struct CategoryBadge: View {
    var category: Category
    @Binding var queryString: String
    @Binding var startSearch: Bool
    
    
    var body: some View {
        Button {
            queryString = category.name
            startSearch = true
        } label: {
            Text(category.name)
                .font(.subheadline)
                .foregroundColor(.primary)
                .padding([.leading, .trailing], 20)
                .padding([.top, .bottom], 10)
                .overlay(
                    Capsule(style: .continuous)
                        .stroke(Color.gray, lineWidth: 1)
                )
        }
        //.padding(.leading, 10)
        
    }
}

struct CategoryBadge_Previews: PreviewProvider {
    @State static var queryString = ""
    @State static var startSearch = true
    static var previews: some View {
        CategoryBadge(category: EventList.categories[0], queryString: $queryString, startSearch: $startSearch)
    }
}
