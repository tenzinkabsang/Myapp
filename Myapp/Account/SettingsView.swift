//
//  SettingView.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/22/22.
//

import SwiftUI

struct SettingsView: View {
    @State private var showSignOutPrompt : Bool = false
    
    @EnvironmentObject private var userViewModel : UserAccountViewModel
    
    
    var body: some View {
        NavigationView {
            
            List {
                // first section
                Section(header: Text("General")) {
                    NavigationLink {
                        ProfileView()
                    } label: {
                        SettingRowView(title: "Profile", systemImageName: "person")
                    }.padding(.vertical, 12)
                
                    
                    NavigationLink {
                        NotificationsView()
                    } label: {
                        SettingRowView(title: "Notifications", systemImageName: "bell")
                    }.padding(.vertical, 12)
                }
                // More sections for other settings...
                
                Section(header: Text("About")) {
                    
                    NavigationLink {
                        PrivacyView()
                    } label: {
                        Text("Privacy")
                    }.padding(.vertical, 12)
                    
                    NavigationLink {
                        TermsOfService()
                    } label: {
                        Text("Terms of service")
                    }.padding(.vertical, 12)
                }
                
                // Last section with the Sign Out Button
                Section(header: Text("")) {
                    Button{
                        // present a confirmation alert
                        self.showSignOutPrompt.toggle()
                    } label: {
                        SettingRowView(title: "Sign Out", systemImageName: "arrow.backward.circle")
                            .foregroundColor(.black)
                    }.padding(.vertical, 12)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert(isPresented : $showSignOutPrompt){
            Alert(title: Text("Are you sure you want to sign out now?"),
                  primaryButton: .default(Text("Yes")) {
                userViewModel.signOut()
            },
                  secondaryButton: .cancel(Text("No")))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
