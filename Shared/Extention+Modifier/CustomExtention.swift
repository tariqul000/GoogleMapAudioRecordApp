//
//  CustomExtention.swift
//  TestMapDemo (iOS)
//
//  Created by Tariqul on 12/11/21.
//

import SwiftUI


struct Title: ViewModifier {
    @State var textSize : Int = 14
    func body(content: Content) -> some View {
        content
            .font(.custom("poppins_regular", size: CGFloat(textSize)))
            .foregroundColor(Color("black"))
    }
}
extension View {
    func titleStyle(fontSize : Int) -> some View {
        self.modifier(Title(textSize: fontSize))
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }.padding(10)
                .foregroundColor(.green)
                .background(LinearGradient(gradient: Gradient(colors: [Color("black"), Color("black")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(20)
                .shadow(color: .gray, radius: 5)

    }
}
