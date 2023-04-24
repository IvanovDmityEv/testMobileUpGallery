//
//  FeedResponce.swift
//  testMobileUpGallery
//
//  Created by Dmitriy on 24.04.2023.
//

import Foundation

struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    var items: [FeedItem]
}

struct FeedItem: Decodable {
    let date: Int
    let id: Int
    let sizes: [Sizes]
}

struct Sizes: Decodable {
    let type: String
    let url: String
}
