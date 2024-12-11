//
//  FeedViewControllerTest.swift
//  PracticeFeediOSTests
//
//  Created by Chowdhury Md Rajib Sarwar on 12/10/24.
//

import XCTest

class FeedViewController {
    init(loader: FeedViewControllerTest.LoaderSpy) {
        
    }
}

class FeedViewControllerTest: XCTest {
    
    func test_init_doesNotLoadFeed() {
        let loader = LoaderSpy()
        let sut = FeedViewController(loader: loader)
        
        XCTAssertEqual(loader.loadCallCount, 0)
    }
    
    
    // MARK: - Helpers
    
    class LoaderSpy {
        private(set) var loadCallCount: Int = 0
    }
}
