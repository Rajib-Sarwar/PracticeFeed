//
//  FeedViewModel.swift
//  PracticeFeediOS
//
//  Created by Chowdhury Md Rajib Sarwar on 12/18/24.
//

import PracticeFeed

final class FeedViewModel {
    private let feedLoader: FeedLoader
    
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    var onChange: ((FeedViewModel) -> Void)?
    var onFeedload: (([FeedImage]) -> Void)?
    
    var isLoading: Bool = false {
        didSet { onChange?(self) }
    }
    
    func loadFeed() {
        isLoading = true
        feedLoader.load { [weak self] result in
            if let feed = try? result.get() {
                self?.onFeedload?(feed)
            }
            self?.isLoading = false
        }
    }
}
