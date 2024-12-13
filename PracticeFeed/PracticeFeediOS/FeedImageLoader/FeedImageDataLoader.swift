//
//  FeedImageDataLoader.swift
//  PracticeFeediOS
//
//  Created by Chowdhury Md Rajib Sarwar on 12/12/24.
//

import Foundation

public protocol FeedImageDataLoaderTask {
    func cancel()
}

public protocol FeedImageDataLoader {
    typealias Result = Swift.Result<Data, Error>
    func loadImageData(from url: URL, completion: @escaping (Result) -> Void) -> FeedImageDataLoaderTask
}
