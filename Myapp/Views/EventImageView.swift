//
//  LiveEventView.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/22/22.
//

import SwiftUI
import SDWebImageSwiftUI



struct EventImageView: View {
    var eventUrl: String
    var cornerRadius: Double?
    var width: Double?
    var height: Double
    
    var body: some View {
        
        GeometryReader { geometry in
            
            let imageWidth: Double = (width == nil || width == .infinity) ? geometry.size.width : width!
            
            let locationUrl = "\(eventUrl)\(Int(imageWidth))x\(Int(height))"
            
            //let locationUrl = "https://firebasestorage.googleapis.com/v0/b/myapp-c9689.appspot.com/o/\(eventUrl)"
            
            WebImage(url: URL(string: locationUrl))
                .resizable()
                .placeholder {
                    Rectangle()
                        .foregroundColor(Color.purple.opacity(0.1))
                        .frame(width: imageWidth, height: height)
                }
                .indicator(.activity)
                .scaledToFill()
                .transition(.fade(duration: 0.5))
                //.frame(minWidth: 0, maxWidth: imageWidth, minHeight: height)
                .frame(width: imageWidth, height: height)
                .cornerRadius(cornerRadius ?? 5)
        }
    }
}

struct LiveEventView_Previews: PreviewProvider {
    static var previews: some View {
        EventImageView(eventUrl: "https://via.placeholder.com/", width: 250, height: 250)
    }
}
