//
//  TabBar.swift
//  MyBarbershop
//
//  Created by ZISACHMAD on 11/05/21.
//

import SwiftUI

struct TabBar: View {
    
    @Binding var selectedTab : String
    @Namespace var animation
    
    var body: some View {
        HStack(spacing: 0) {
            TabBarButton(animation: animation, image: "house", selectedTab: $selectedTab)
            TabBarButton(animation: animation, image: "bookmark", selectedTab: $selectedTab)
            TabBarButton(animation: animation, image: "message", selectedTab: $selectedTab)
            TabBarButton(animation: animation, image: "person", selectedTab: $selectedTab)
        }
        .background(Color.white)
        .padding(.bottom,getSafeArea().bottom == 0 ? 10 : getSafeArea().bottom)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension View {
    func getSafeArea() -> UIEdgeInsets {
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

struct TabBarButton: View {
    
    var animation : Namespace.ID
    var image: String
    @Binding var selectedTab: String
    
    var body: some View {
        
        Button( action: {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)) {selectedTab = image}
        }, label: {
            VStack {
                Image(systemName: "\(image)\(selectedTab == image ? ".fill" : "")")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundColor(selectedTab == image ? Color.black : Color.gray)
                if selectedTab == image {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 8, height: 8)
                        .matchedGeometryEffect(id: "TAB", in: animation)
                }
            }
        })
//        .padding(.vertical)
        .frame(maxWidth: .infinity, maxHeight: 60)
    }
}


