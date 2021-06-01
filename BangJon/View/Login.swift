//
//  Login.swift
//  MyBarbershop
//
//  Created by ZISACHMAD on 15/05/21.
//

import SwiftUI
import StreamChat

struct Login: View {
    
    @EnvironmentObject var streamData : StreamViewModel
    @Environment(\.colorScheme) var colorScheme // UBAH WARNA SESUAI TEMA IPHONE
    
    var body: some View {
        VStack {
            TextField("Bang Jon", text: $streamData.userName)
                .modifier(ShadowModifier())
                .padding(.top,20)
            Button(action: streamData.logInUser, label: {
                HStack {
                    Spacer()
                    Text("Login")
                    Spacer()
                    Image(systemName: "arrow.right")
                }
                .padding(.vertical,10)
                .padding(.horizontal)
                .background(Color.primary)
                .foregroundColor(colorScheme == .dark ? .black : .white)
                .cornerRadius(5)
            })
            .padding(.top,20)
            .disabled(streamData.userName == "")
            .opacity(streamData.userName == "" ? 0.5 :1)
            Spacer()
        }
        .padding()
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}

// MODIFIER SHADOW FLEKSIBEL SESUAI TEMA IPHONE
struct ShadowModifier: ViewModifier {
    
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        return content
            .padding(.vertical,10)
            .padding(.horizontal)
            .background(colorScheme != .dark ? Color.white : Color.black)
            .cornerRadius(8)
            .clipped()
            .shadow(color: Color.primary.opacity(0.04), radius: 5, x: 5, y: 5)
            .shadow(color: Color.primary.opacity(0.04), radius: 5, x: -5, y: -5)
    }
}
