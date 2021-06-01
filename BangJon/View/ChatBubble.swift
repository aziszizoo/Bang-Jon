//
//  ChatBubble.swift
//  MyBarbershop
//
//  Created by ZISACHMAD on 15/05/21.
//

import SwiftUI
import StreamChat

struct ChatBubble: Shape {
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 13, height: 13))
        return Path(path.cgPath)
    }
}
