//
//  AccountLandingView.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/22/22.
//

import SwiftUI

struct AccountLandingView: View {
    
    @EnvironmentObject private var userAccountViewModel : UserAccountViewModel
    
    var body: some View {
        
        if userAccountViewModel.hasSignedIn {
            SettingsView()
        } else {
            SignInView()
        }
    }
}

struct AccountLandingView_Previews: PreviewProvider {
    static var previews: some View {
        AccountLandingView()
    }
}
