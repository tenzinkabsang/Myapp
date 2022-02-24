//
//  SettingRowView.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/22/22.
//

import SwiftUI

struct SettingRowView: View {
    var title : String
        var systemImageName : String
        
        var body : some View {
            HStack (spacing : 15) {
                Image(systemName: systemImageName)
                Text (title)
            }
        }
}

struct SettingRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingRowView(title: "Hello", systemImageName: "star")
    }
}
