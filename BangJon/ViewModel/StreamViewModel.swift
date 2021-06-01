//
//  StreamViewModel.swift
//  MyBarbershop
//
//  Created by ZISACHMAD on 15/05/21.
//

import SwiftUI
import StreamChat

class StreamViewModel: ObservableObject {
    
    @Published var userName = ""
    @AppStorage("userName") var storedUser = ""
    @AppStorage("log_Status") var logStatus = false
    
    // ALERT ERROR
    @Published var error = false
    @Published var errorMsg = ""
    
    // LOADING SCREEN
    @Published var isLoading = false
    
    // CHAT DATA
    @Published var channels : [ChatChannelController.ObservableObject]!
    
    // CREATE NEW CHAT
    @Published var createNewChannel = false
    @Published var channelName = ""
    
    // LOGIN USER
    func logInUser() {
        
        withAnimation{isLoading = true}
        let config = ChatClientConfig(apiKeyString: APIKey)
        
        ChatClient.shared = ChatClient(config: config, tokenProvider: .development(userId: userName))
        ChatClient.shared.currentUserController().reloadUserIfNeeded { (err) in
            
            withAnimation{self.isLoading = false}
            
            if let error = err {
                self.errorMsg = error.localizedDescription
                self.error.toggle()
                return
            }
            // JIKA SUKSES SIMPAN USERNAME
            self.storedUser = self.userName
            self.logStatus = true
        }
    }
    
    // TAMPILKAN SEMUA CHAT
    func fectAllChannels() {
        if channels == nil {
            
            let filter = Filter<ChannelListFilterScope>.equal("type", to: "messaging")
            let request = ChatClient.shared.channelListController(query: .init(filter: filter))
            
            request.synchronize { (err) in
                if let error = err {
                    self.errorMsg = error.localizedDescription
                    self.error.toggle()
                    return
                }
                self.channels = request.channels.compactMap( { (channel) -> ChatChannelController.ObservableObject? in
                    return ChatClient.shared.channelController(for: channel.cid).observableObject
                })
            }
        }
    }
    
    // MEMBUAT NEW CHAT
    func createChannel() {
        
        withAnimation{self.isLoading = true}
        let normalizedChannelName = channelName.replacingOccurrences(of: " ", with: "-")
        let newChannel = ChannelId(type: .messaging, id: normalizedChannelName)
        let request = try! ChatClient.shared.channelController(createChannelWithId: newChannel, name: normalizedChannelName, imageURL: nil, extraData: .defaultValue)
        
        request.synchronize() { (err) in
            withAnimation{self.isLoading = false}
            if let error = err {
                self.errorMsg = error.localizedDescription
                self.error.toggle()
                return
            }
            self.channelName = ""
            withAnimation{self.createNewChannel = false}
            self.channels = nil
            self.fectAllChannels()
        }
    }
}


