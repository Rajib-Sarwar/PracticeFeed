//
//  FeedLoader.swift
//  PracticeFeed
//
//  Created by Chowdhury Md Rajib Sarwar on 11/5/24.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
