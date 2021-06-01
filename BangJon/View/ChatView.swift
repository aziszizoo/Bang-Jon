//
//  ChatView.swift
//  MyBarbershop
//
//  Created by ZISACHMAD on 15/05/21.
//

import SwiftUI
import StreamChat

struct ChatView: View {
    
    @StateObject var listner: ChatChannelController.ObservableObject
    @State var message = ""
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        let channel = listner.controller.channel!
        
        VStack {
            ScrollViewReader { reader in
                ScrollView(.vertical, showsIndicators: false, content: {
                    LazyVStack(alignment: .center, spacing: 15, content: {
                        ForEach(listner.messages.reversed(),id: \.self) { msg in
                            MessageRowView(message: msg) // BARIS CHAT
                        }
                    })
                    .padding()
                    .padding(.bottom,10)
                    .id("MSG_VIEW")
                })
                .onChange(of: listner.messages, perform: { value in withAnimation{reader.scrollTo("MSG_VIEW", anchor: .bottom)} })
                .onAppear(perform: {reader.scrollTo("MSG_VIEW", anchor: .bottom)})
            }
            // KOTAK KETIKAN DAN TOMBOL SEND
            HStack(spacing: 10) {
                TextField("Message", text: $message)
                    .modifier(ShadowModifier())
                Button(action: sendMessage, label: {
                    Image(systemName: "paperplane.fill")
                        .padding(10)
                        .background(Color.primary)
                        .foregroundColor(scheme == .dark ? .black : .white)
                        .clipShape(Circle())
                })
                // DISABLE JIKA TIDAK NGETIK
                .disabled(message == "")
                .opacity(message == "" ? 0.5 : 1)
            }
            .padding(.horizontal)
            .padding(.bottom,8)
        }
        .navigationTitle(channel.cid.id)
    }
    // KIRIM CHAT
    func sendMessage() {
        let channelID = ChannelId(type: .messaging, id: listner.channel?.cid.id ?? "")
        ChatClient.shared.channelController(for: channelID).createNewMessage(text: message) { result in
            switch result {
            case .success(let id):
                print("succes = \(id)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        message = ""
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
