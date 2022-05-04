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
    var imageSize: Double = 40
    var image: Image? = nil
    
    var body: some View {
        
        if let image = image {
            LocalImage(image: image)
        } else {
            webImage
        }
    }
    
    @ViewBuilder
    func LocalImage(image: Image) -> some View {
            image
            .resizable()
            .scaledToFill()
            .frame(width: imageSize, height: imageSize)
            .clipShape(Circle())
            .overlay{
                Circle().stroke(.white, lineWidth: 2)
            }
            .shadow(radius: 7)
    }
    
       
    @ViewBuilder var webImage: some View {
        WebImage(url: URL(string: imageUrl))
            .resizable()
            .scaledToFill()
            .frame(width: imageSize, height: imageSize)
            .clipShape(Circle())
            .overlay{
                Circle().stroke(.white, lineWidth: 2)
            }
            .shadow(radius: 7)
    }
    
//    @ViewBuilder var webImage: some View {
//        WebImage(url: URL(string: imageUrl))
//            .resizable()
//            .placeholder {
//                Circle()
//                    .foregroundColor(Color.purple.opacity(0.1))
//                    .frame(width: imageSize, height: imageSize)
//            }
//            .onFailure { error in
//                //Image(systemName: "person.circle")
//            }
//            .transition(.fade(duration: 0.5))
//            .scaledToFill()
//            .frame(width: imageSize, height: imageSize)
//            .clipShape(Circle())
//            .overlay{
//                Circle().stroke(.white, lineWidth: 2)
//            }
//            .shadow(radius: 7)
//    }
}


struct CardProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        CardProfileImage(
            imageUrl: "https://firebasestorage.googleapis.com/v0/b/myapp-c9689.appspot.com/o/profile%2F03B2507D-3C8A-4947-BD23-515EC079C102?alt=media&token=9d846b6e-a82a-41ee-aec8-ca70e4e17a58",
            imageSize: 120,
            image: Image("person"))
    }
}
