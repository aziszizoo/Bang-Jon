//
//  ContentView.swift
//  MyBarbershop
//
//  Created by ZISACHMAD on 10/05/21.
//

import SwiftUI
import StreamChat

struct ContentView: View {
    
    @StateObject var streamData = StreamViewModel()
    @StateObject var model = LoginViewModel()
    @AppStorage("log_Status") var logStatus = false
    
    var body: some View {
        NavigationView {
            if !logStatus {
                OtpLogin()
                    .environmentObject(model)
                    .navigationTitle("Login")
            }
            else {
                ChannelView()
            }
        }
        .background(ZStack {
            Text("")
                .alert(isPresented: $model.showAlert, content: {
                    Alert(title: Text("Message"), message: Text(model.errorMsg), dismissButton: .destructive(Text("Ok"), action: {
                        withAnimation{model.isLoading = false}
                    }))
                })
            Text("")
                .alert(isPresented: $streamData.error, content: {
                    Alert(title: Text("Message"), message: Text(streamData.errorMsg), dismissButton: .destructive(Text("Ok"), action: {
                        withAnimation{streamData.isLoading = false}
                    }))
                })
        })
        .overlay(
            ZStack {
                if streamData.createNewChannel {CreateNewChannel()} // NEW CHAT VIEW
                if model.isLoading || streamData.isLoading {LoadingScreen()} // LOADING SCREEN
            }
        )
        .environmentObject(streamData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
