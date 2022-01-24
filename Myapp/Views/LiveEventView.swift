//
//  LiveEventView.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/22/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct LiveEventView: View {
    var eventUrl: String
    var cornerRadius: Double?
    var width: Double?
    var height: Double
    
    
    var body: some View {
        
        GeometryReader { geometry in
            
            let imageWidth: Double = width ?? geometry.size.width
            
            let locationUrl = "\(eventUrl)\(Int(imageWidth))x\(Int(height))"
            
            WebImage(url: URL(string: locationUrl))
                .resizable()
                .placeholder {
                    Rectangle()
                        .foregroundColor(Color.purple.opacity(0.1))
                        .frame(width: imageWidth, height: height)
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .frame(width: imageWidth, height: height)
                .cornerRadius(cornerRadius ?? 5)
            
            /**
             AsyncImage(url: URL(string: locationUrl)) { img in
             img.resizable()
             .scaledToFill()
             } placeholder: {
             Color.purple.opacity(0.1)
             }
             .frame(width: imageWidth, height: height)
             .cornerRadius(cornerRadius ?? 5)
             **/
            
            //            AsyncImage(url: URL(string: locationUrl)){ phase in
            //                if let image = phase.image {
            //                    image
            //                        .resizable()
            //                        .scaledToFill()
            //                } else if phase.error != nil {
            //                    Text(phase.error?.localizedDescription ?? "error")
            //                        .foregroundColor(Color.pink)
            //                        .frame(width: imageWidth, height: height)
            //                } else {
            //                    Color.purple.opacity(0.1)
            //                }
            //            }
            //            .frame(width: imageWidth, height: height)
            //            .cornerRadius(cornerRadius ?? 5)
            
            
        }
    }
}

struct LiveEventView_Previews: PreviewProvider {
    static var previews: some View {
        LiveEventView(eventUrl: "https://via.placeholder.com/", width: 250, height: 250)
    }
}
