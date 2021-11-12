//
//  SecureInputView.swift
//  TestMapDemo (iOS)
//
//  Created by Tariqul on 12/11/21.
//

import SwiftUI

struct SecureInputView: View {
    
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            if isSecured {
                SecureField("", text: $text)
                    .foregroundColor(.white)
                    .placeholder(when: text.isEmpty) {
                        Text("Password").foregroundColor(Color("light_gray"))}
            } else {
                TextField("", text: $text)
                    .foregroundColor(.white)
                    .placeholder(when: text.isEmpty) {
                        Text("Password").foregroundColor(Color("light_gray"))}
            }
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .padding(.horizontal, 20)
                    .accentColor(Color("light_gray"))
            }
        }
    }
}
