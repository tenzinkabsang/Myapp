//
//  SignInView.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/22/22.
//

import Foundation
import SwiftUI

struct SignInView : View {
    
    @State private var loggingIn = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Button {
                    loggingIn.toggle()
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
                        loggingIn.toggle()
                    } label: {
                        Text("Sign up")
                    }
                }
                
            }
            .sheet(isPresented: $loggingIn) {
                SignInViewUI()
            }
            .navigationBarHidden(true)
        }
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}


struct SignInViewUI: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<SignInViewUI>) -> UIViewController {
        //return AM.shared.authViewController
        return AuthManager.shared.authView
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<SignInViewUI>) {
        // empty
    }
}
