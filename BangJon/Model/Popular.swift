//
//  Popular.swift
//  MyBarbershop
//
//  Created by ZISACHMAD on 11/05/21.
//

import SwiftUI

struct Popular: Identifiable {
    var id = UUID().uuidString
    var title: String
    var description: String
    var image: String
    var price: String
}

var popular_items = [
    Popular(title: "Crop Cut", description: "Low maintenance haircut", image: "cropcut", price: "60"),
    Popular(title: "Excecutive", description: "Give you more confidence", image: "executivecut", price: "70"),
    Popular(title: "Fade", description: "Growm Faint & Disappear", image: "fadecut", price: "50"),
    Popular(title: "Pompadour", description: "Icon of american spirit", image: "pompadour", price: "50"),
    Popular(title: "Flat Top", description: "Among Military Men", image: "flattop", price: "30")
]
