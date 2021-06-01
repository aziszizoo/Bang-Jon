//
//  ChannelView.swift
//  MyBarbershop
//
//  Created by ZISACHMAD on 15/05/21.
//

import SwiftUI
import StreamChat

struct ChannelView: View {
    
    @EnvironmentObject var streamData : StreamViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(spacing: 20) {
                if let channels = streamData.channels {
                    ForEach(channels,id: \.channel) { listner in
                        NavigationLink(
                            destination: ChatView(listner: listner),
                            label: {
                            ChannelRowView(listner: listner)
                        })
                    }
                }
                else {
                    ProgressView()
                        .padding(.top,20)
                }
            }
            .padding()
        })
        .navigationTitle("Bang Jon Chat")
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    streamData.channels = nil
                    streamData.fectAllChannels()
                }, label: {
                    Image(systemName: "arrow.clockwise.circle.fill")
                })
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    withAnimation{streamData.createNewChannel.toggle()}
                }, label: {
                    Image(systemName: "square.and.pencil")
                })
            }
        })
        .onAppear(perform: {
            streamData.fectAllChannels()
        })
    }
}

struct ChannelView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelView()
    }
}


//BARIS CHAT
struct ChannelRowView: View {
    
    @StateObject var listner: ChatChannelController.ObservableObject
    @EnvironmentObject var streamData: StreamViewModel
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 5, content: {
            HStack(spacing: 12) {
                let channel = listner.controller.channel!
                // HURUF PERTAMA JADI PROFILE PICTURE
                Circle()
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 55, height: 55)
                    .overlay(Text("\(String(channel.cid.id.first!))") // CODING AMBIL HURUF PERTAMA
                                .font(.title)
                                .fontWeight(.semibold))
                VStack(alignment: .leading, spacing: 8, content: {
                    Text(channel.cid.id)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    if let lastMsg = channel.latestMessages.first {
                        (
                            Text(lastMsg.isSentByCurrentUser ? "Me: " : "\(lastMsg.author.id): ")
                                +
                                Text(lastMsg.text)
                        )
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                    }
                })
                Spacer(minLength: 10)
                
                if let time = channel.latestMessages.first?.createdAt {
                    Text(time,style: checkIsDateToday(date: time) ? .time : .date)
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
            .frame(minWidth: .infinity, alignment: .leading)
            
            Divider()
                .padding(.leading,60)
        })
        .onAppear(perform: {
            listner.controller.synchronize() })
        .onChange(of: listner.controller.channel?.latestMessages.first?.text, perform: { value in
            print("sort channels...")
            sortChannels() })
        .padding()
    }
    func checkIsDateToday(date: Date) -> Bool {
        let calender = Calendar.current
        if calender.isDateInToday(date) {
            return true
        }
        else {
            return false
        }
    }
    func sortChannels() {
        let result = streamData.channels.sorted { (ch1, ch2) -> Bool in
            if let date1 = ch1.channel?.latestMessages.first?.createdAt {
                if let date2 = ch2.channel?.latestMessages.first?.createdAt {
                    return date1 > date2
                }
                else {
                    return false
                }
            }
            else {
                return false
            }
        }
        streamData.channels = result
    }
}
