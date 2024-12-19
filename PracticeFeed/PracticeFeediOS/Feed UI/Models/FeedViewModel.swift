//
//  FeedViewModel.swift
//  PracticeFeediOS
//
//  Created by Chowdhury Md Rajib Sarwar on 12/18/24.
//

import PracticeFeed

final class FeedViewModel {
    typealias Observer<T> = (T) -> Void
    private let feedLoader: FeedLoader
    
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    var onLoadingStateChange: Observer<Bool>?
    var onFeedload: Observer<[FeedImage]>?
    
    func loadFeed() {
        onLoadingStateChange?(true)
        feedLoader.load { [weak self] result in
            if let feed = try? result.get() {
                self?.onFeedload?(feed)
            }
            self?.onLoadingStateChange?(false)
        }
    }
}
