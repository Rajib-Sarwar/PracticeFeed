//
//  FeedLoader.swift
//  PracticeFeed
//
//  Created by Chowdhury Md Rajib Sarwar on 11/5/24.
//

import Foundation

public protocol FeedLoader {
    typealias Result = Swift.Result<[FeedImage], Error>
    
    func load(completion: @escaping (Result) -> Void)
}
