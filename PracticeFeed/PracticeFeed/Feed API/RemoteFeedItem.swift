//
//  RemoteFeedItem.swift
//  PracticeFeed
//
//  Created by Chowdhury Md Rajib Sarwar on 11/16/24.
//

import Foundation

struct RemoteFeedItem: Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL
}
