//
//  FeedLoader.swift
//  PracticeFeed
//
//  Created by Chowdhury Md Rajib Sarwar on 11/5/24.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedImage])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
