//
//  PopularItemRowView.swift
//  MyBarbershop
//
//  Created by ZISACHMAD on 11/05/21.
//

import SwiftUI

struct PopularItemRowView: View {
    var item: Popular
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .top) {
                Image(item.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: getRect().width / 2.5)
                    .cornerRadius(20)
//                Image(systemName: "flame")
//                    .font(.callout)
//                    .foregroundColor(.white)
//                    .padding(8)
//                    .background(Color(#colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 0.5)))
//                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
//                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Text(item.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .padding(.top,10)
            Text(item.description)
                .font(.footnote)
                .foregroundColor(.gray)
            (
                Text("Rp. ")
                    .font(.footnote)
                    .foregroundColor(.white)
                +
                    Text(item.price)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                +
                    Text(" K")
                    .font(.footnote)
                    .foregroundColor(.white)
            )
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .padding(.top,5)
        }
        .padding(.vertical)
        .padding(.horizontal,30)
        .background(LinearGradient(gradient: .init(colors: [Color("g2"),Color("g1")]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.04), radius: 5, x: 5, y: 5)
    }
}

struct PopularItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
