//
//  CardProfileImage.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/22/22.
//

import SwiftUI

struct CardProfileImage: View {
    var imageUrl: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { img in
            img.resizable()
        } placeholder: {
            Color.gray
        }
        .frame(width: 40, height: 40)
        .clipShape(Circle())
        .overlay{
            Circle().stroke(.white, lineWidth: 2)
        }
        .shadow(radius: 7)
        
        
    }
}

struct CardProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        CardProfileImage(
            imageUrl: "https://avatars.githubusercontent.com/u/1808150?s=400&u=56f519596ffe7ab040c50ffd1e0a9ad546353bef&v=4")
    }
}
