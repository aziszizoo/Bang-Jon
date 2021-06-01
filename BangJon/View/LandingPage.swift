//
//  LandingPage.swift
//  MyBarbershop
//
//  Created by ZISACHMAD on 11/05/21.
//

import SwiftUI

struct LandingPage: View {
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    @State var selectedCategory : Category = categories.first!
    @State var selectedtab : String = "house"
    var white: Color = .white.opacity(0.75)
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedtab) {
                Home(selectedCategory: selectedCategory)
                    .tag("house")
                Color.yellow
                    .tag("bookmark")
                Color.blue
                    .tag("message")
                Color.green
                    .tag("person")
            }
//            .ignoresSafeArea()
            TabBar(selectedTab: $selectedtab)
            
            
            
            
            
        }
        .ignoresSafeArea()
    }
}

struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage()
    }
}
