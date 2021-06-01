//
//  CreateNewChannel.swift
//  MyBarbershop
//
//  Created by ZISACHMAD on 15/05/21.
//

import SwiftUI
import StreamChat

struct CreateNewChannel: View {
    
    @EnvironmentObject var streamData: StreamViewModel
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Text("Create New Chat")
                .font(.title2)
                .fontWeight(.bold)
            TextField("Bang Jon", text: $streamData.channelName)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .modifier(ShadowModifier())
            Button(action: streamData.createChannel, label: {
                Text("Create Chat")
                    .padding(.vertical,10)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.primary)
                    .foregroundColor(scheme == .dark ? .black : .white)
                    .cornerRadius(8)
            })
            .padding(.top,10)
            .disabled(streamData.channelName == "")
            .opacity(streamData.channelName == "" ? 0.5 : 1)
        })
        .padding()
        .background(scheme == .dark ? Color.black : Color.white)
        .cornerRadius(12)
        .padding(.horizontal,35)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primary.opacity(0.2)
                        .ignoresSafeArea().onTapGesture {
                            streamData.channelName = ""
                            withAnimation{streamData.createNewChannel.toggle()}
        })
    }
}

struct CreateNewChannel_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewChannel()
    }
}
