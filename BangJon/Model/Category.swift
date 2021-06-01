//
//  Category.swift
//  MyBarbershop
//
//  Created by ZISACHMAD on 11/05/21.
//

import SwiftUI

struct Category: Identifiable {
    var id: String = UUID().uuidString
    var image: String
    var title: String
}

var categories = [
    Category(image: "scissors", title: "Hair Cut"),
    Category(image: "comb.fill", title: "Hair Style"),
    Category(image: "paintbrush.pointed.fill", title: "Hair Coloring"),
    Category(image: "mustache.fill", title: "Shaving"),
    Category(image: "face.smiling", title: "Junior Cut")

]
