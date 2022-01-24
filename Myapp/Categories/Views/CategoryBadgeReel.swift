//
//  CategoryBadgeReel.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/23/22.
//

import SwiftUI

struct CategoryBadgeReel: View {
    
    var events: [Event]
    
    
    private func getDistinctCategories() -> [String] {
        var distinct = [String]()
        
        events.forEach { event in
            if !distinct.contains(event.category) {
                distinct.append(event.category)
            }
        }
        return distinct
    }
    
    var body: some View {
        
        // Loop through categories and display a category batch view for each
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                let categories = getDistinctCategories()
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
        CategoryBadgeReel(events: EventList.allEvents)
    }
}
