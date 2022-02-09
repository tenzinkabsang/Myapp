//
//  ExDivider.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 2/3/22.
//

import SwiftUI
struct ExDivider: View {
    let color: Color = .clear
    let width: CGFloat = 0.5
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}
