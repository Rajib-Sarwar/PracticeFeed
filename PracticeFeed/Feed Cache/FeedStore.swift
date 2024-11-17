//
//  FeedStore.swift
//  PracticeFeed
//
//  Created by Chowdhury Md Rajib Sarwar on 11/15/24.
//

import Foundation

public enum RetrieveCcaheFeedResult {
    case empty
    case found(feed: [LocalFeedImage], timestamp: Date)
    case failure(Error)
}

public protocol FeedStore {
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    typealias RetrievalCompletion = (RetrieveCcaheFeedResult) -> Void
    
    func deleteCahedFeed(completion: @escaping DeletionCompletion)
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion)
    func retrieve(completion: @escaping RetrievalCompletion)
}
