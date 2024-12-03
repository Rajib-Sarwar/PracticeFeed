//
//  CoreDataFeedStore.swift
//  PracticeFeed
//
//  Created by Chowdhury Md Rajib Sarwar on 12/2/24.
//

import Foundation

public final class CoreDataFeedStore: FeedStore {
    
    public init() {}
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        completion(.empty)
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        
    }
    
    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {

    }
}
