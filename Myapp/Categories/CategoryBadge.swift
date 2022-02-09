//
//  CategoryBadge.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/23/22.
//

import SwiftUI


struct CategoryBadge: View {
    var category: Category
    
    
    var body: some View {
        Button {
            //TODO: Display the search view for this category
        } label: {
            Text(category.name)
                .font(.subheadline)
                .foregroundColor(.primary)
                .padding([.leading, .trailing], 20)
                .padding([.top, .bottom], 5)
                .overlay(
                    Capsule(style: .continuous)
                        .stroke(Color.gray, lineWidth: 1)
                )
        }
        //.padding(.leading, 10)
        
    }
}

struct CategoryBadge_Previews: PreviewProvider {
    static var previews: some View {
        CategoryBadge(category: EventList.categories[0])
    }
}
