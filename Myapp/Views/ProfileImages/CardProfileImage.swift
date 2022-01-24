//
//  CardProfileImage.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/22/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardProfileImage: View {
    var imageUrl: String
    
    private let imageSize: Double = 40
    
    var body: some View {
        
        WebImage(url: URL(string: imageUrl))
            .resizable()
            .placeholder {
                Circle()
                    .foregroundColor(Color.purple.opacity(0.1))
                    .frame(width: imageSize, height: imageSize)
            }
            .onFailure { error in
                //Image(systemName: "person.circle")
            }
            .transition(.fade(duration: 0.5))
            .frame(width: imageSize, height: imageSize)
            .clipShape(Circle())
            .overlay{
                Circle().stroke(.white, lineWidth: 2)
            }
            .shadow(radius: 7)
        
        
        /**
        AsyncImage(url: URL(string: imageUrl), transaction: Transaction(animation: .spring())) { phase in
            switch phase {
            case .empty:
                Color.purple.opacity(0.1)
                
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                
            case .failure(_):
                Image(systemName: "person.circle")
                                
            @unknown default:
                Image(systemName: "person.circle")
            }
        }
        .frame(width: 40, height: 40)
        .clipShape(Circle())
        .overlay{
            Circle().stroke(.white, lineWidth: 2)
        }
        .shadow(radius: 7)
           **/
    }
}

struct CardProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        CardProfileImage(
            imageUrl: "https://avatars.githubusercontent.com/u/1808150?s=400&u=56f519596ffe7ab040c50ffd1e0a9ad546353bef&v=4")
    }
}
