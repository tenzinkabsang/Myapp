//
//  SignupLandingView.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/18/22.
//

import SwiftUI

struct SignupLandingView: View {
    var body: some View {
        
        NavigationView {
            VStack(spacing: 20) {
                
                Button {
                    
                } label: {
                    
                    Text("Log in")
                        .font(.title3)
                        .fontWeight(.medium)
                        .kerning(1.1)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            Capsule()
                                .strokeBorder(.blue)
                        )
                }
                .padding()
                
                HStack{
                    Text("Don't have an account?")
                    
                    Button {
                        
                    } label: {
                        Text("Sign up")
                    }
                    
                }
                
            }
            .navigationTitle("New")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SignupLandingView_Previews: PreviewProvider {
    static var previews: some View {
        SignupLandingView()
    }
}
