//
//  FeedItem.swift
//  PracticeFeed
//
//  Created by Chowdhury Md Rajib Sarwar on 11/5/24.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
