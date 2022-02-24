//
//  ProfileView.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/23/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var userAccountViewModel : UserAccountViewModel
    
    var body: some View {
        Text("Profile view")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
