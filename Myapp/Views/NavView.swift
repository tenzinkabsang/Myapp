//
//  NavView.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/29/22.
//

import SwiftUI

struct NavView: View {
    
    var body: some View {
       
        
        HStack {
            Text("Logo")
                .font(.title)
            
            Spacer()
            
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 25, height: 25)
        }
        .foregroundColor(.purple)
        .padding(.horizontal)
    }
}

struct NavView_Previews: PreviewProvider {
    static var previews: some View {
        NavView()
    }
}
