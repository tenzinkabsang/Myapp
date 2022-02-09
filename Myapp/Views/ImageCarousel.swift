//
//  ImageCarousel.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/3/22.
//

import SwiftUI

struct ImageCarousel: View {
    @Environment(\.dismiss) var dismiss
    
    var imageUrl: String
    
    var body: some View {
        VStack{
            HStack {
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 40, weight: .ultraLight))
                        .foregroundColor(.black)
                        .padding()
                }
            }
            Spacer()
            
            EventImageView(eventUrl: imageUrl, cornerRadius: 0,  height: 450)
                .frame(height: 450, alignment: .center)
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct ImageCarousel_Previews: PreviewProvider {
    static var previews: some View {
        ImageCarousel(imageUrl: "https://via.placeholder.com/")
    }
}
