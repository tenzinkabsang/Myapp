//
//  CategoryBadgeReel.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/23/22.
//

import SwiftUI

struct CategoryBadgeReel: View {
    var categories: [Category]
    @Binding var queryString: String
    @Binding var startSearch: Bool
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(categories) { category in
                    CategoryBadge(category: category, queryString: $queryString, startSearch: $startSearch)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 7)
        }
    }
}

struct CategoryBadgeReel_Previews: PreviewProvider {
    
    @State static var queryString = ""
    @State static var startSearch = true
    static var previews: some View {
        CategoryBadgeReel(categories: EventList.categories, queryString: $queryString, startSearch: $startSearch)
    }
}
