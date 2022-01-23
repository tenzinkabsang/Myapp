//
//  LiveEventView.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/22/22.
//

import SwiftUI

struct LiveEventView: View {
    var eventUrl: String
    var cornerRadius: Double?
    var width: Double?
    var height: Double
    
    
    var body: some View {
        
        GeometryReader { geometry in
            
            let imageWidth: Double = width ?? geometry.size.width
            
            let locationUrl = "\(eventUrl)\(Int(imageWidth))x\(Int(height))"
            
            AsyncImage(url: URL(string: locationUrl)) { img in
                img.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: imageWidth, height: height)
            .cornerRadius(cornerRadius ?? 5)
            //.clipShape(RoundedRectangle(cornerRadius: 5))
        }
    }
}

struct LiveEventView_Previews: PreviewProvider {
    static var previews: some View {
        LiveEventView(eventUrl: "https://via.placeholder.com/", width: 250, height: 250)
    }
}
