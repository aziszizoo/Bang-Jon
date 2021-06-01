//
//  MessageRowView.swift
//  MyBarbershop
//
//  Created by ZISACHMAD on 15/05/21.
//

import SwiftUI
import StreamChat

struct MessageRowView: View {
    
    var message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isSentByCurrentUser {
                Spacer()
            }
            HStack(alignment: .bottom, spacing: 10) {
                if !message.isSentByCurrentUser {
                    UserView(message: message)
                        .offset(y: 10)
                }
                // CHAT DENGAN FRAME BUBBLE
                VStack(alignment: message.isSentByCurrentUser ? .trailing : .leading, spacing: 6, content: {
                    Text(message.text)
                    Text(message.createdAt,style: .time)
                        .font(.caption)
                })
                .padding([.horizontal,.top])
                .padding(.bottom,8)
                .background(message.isSentByCurrentUser ? Color.blue : Color.gray.opacity(0.4))
                .clipShape(ChatBubble(corners: message.isSentByCurrentUser ? [.topLeft,.topRight,.bottomLeft] : [.topLeft,.topRight,.bottomRight]))
                .foregroundColor(message.isSentByCurrentUser ? .white : .primary)
                .frame(width: UIScreen.main.bounds.width - 150, alignment: message.isSentByCurrentUser ? .trailing : .leading)
                if message.isSentByCurrentUser {
                    UserView(message: message)
                        .offset(y: 10)
                }
            }
            if !message.isSentByCurrentUser {
                Spacer()
            }
        }
    }
}

// LIHAT PROFILE DAN STATUS ONLINE
struct UserView: View {
    
    var message: ChatMessage
    
    var body: some View {
        Circle()
            .fill(message.isSentByCurrentUser ? Color.blue : Color.gray.opacity(0.4))
            .frame(width: 40, height: 40)
            .overlay(Text("(String(message.author.id.first!))")
                        .fontWeight(.semibold)
                        .foregroundColor(message.isSentByCurrentUser ? .white : .primary))
            // TAMPILKAN USERNAME DAN STATUS ONLINE
            .contextMenu(menuItems: {
                Text("(message.author.id)")
                if message.author.isOnline {
                    Text("Lagi Online")
                }
                else {
                    Text(message.author.lastActiveAt ?? Date(),style: .time)
                }
            })
    }
}
