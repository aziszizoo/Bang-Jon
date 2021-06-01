//
//  OtpLogin.swift
//  BangJon
//
//  Created by ZISACHMAD on 16/05/21.
//

import SwiftUI

struct OtpLogin: View {
    
    @EnvironmentObject var model : LoginViewModel
    
    var body: some View {
        VStack {
            Image("delivery")
                .resizable()
                .frame(width: 200 ,height: 160)
                .padding()
            HStack(spacing: 15) {
                TextField("+62", text: $model.countryCode)
                    .keyboardType(.numberPad)
                    .padding(.vertical,12)
                    .padding(.horizontal)
                    .frame(width: 70)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(model.countryCode == "" ? Color.gray : Color.green))
                TextField("82121255555", text: $model.phNumber)
                    .keyboardType(.numberPad)
                    .padding(.vertical,12)
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(model.phNumber == "" ? Color.gray : Color.green))
            }
            .padding(.top,10)
            Button(action: model.verifyUser, label: {
                Text("Login Jon")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .padding(.vertical,15)
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(8)
            })
            .disabled(model.countryCode == "" || model.phNumber == "")
            .opacity(model.countryCode == "" || model.phNumber == "" ? 0.6 : 1)
            .padding(.top,20)
            Spacer()
        }
        .padding()
    }
}

struct OtpLogin_Previews: PreviewProvider {
    static var previews: some View {
        OtpLogin()
    }
}
