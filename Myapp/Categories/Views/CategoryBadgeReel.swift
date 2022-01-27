//
//  CategoryBadgeReel.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/23/22.
//

import SwiftUI

struct CategoryBadgeReel: View {
    
    var categories: [String]
    
    
    var body: some View {
        
        // Loop through categories and display a category batch view for each
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
    
                ForEach(categories, id:\.self) { category in
                    CategoryBadge(category: category)
                }
            }
            .padding(.leading, 10)
        }
    }
}

struct CategoryBadgeReel_Previews: PreviewProvider {
    static var previews: some View {
        CategoryBadgeReel(categories: EventList.allEvents.map{ e in
            e.category
        })
    }
}
