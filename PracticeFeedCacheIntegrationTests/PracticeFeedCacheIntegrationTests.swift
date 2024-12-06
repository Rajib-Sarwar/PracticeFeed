//
//  PracticeFeedCacheIntegrationTests.swift
//  PracticeFeedCacheIntegrationTests
//
//  Created by Chowdhury Md Rajib Sarwar on 12/4/24.
//

import XCTest
import PracticeFeed

final class PracticeFeedCacheIntegrationTests: XCTestCase {

    override func setUp() {
        super.setUp()
        deletestoreArtifact()
    }
    
    override func tearDown() {
        super.tearDown()
        deletestoreArtifact()
    }
    
    func test_load_deliversNoItemOnEmptyCache() {
        let sut = makeSUT()
        
        let exp = expectation(description: "Wait for cache retrieval")
        sut.load { result in
            switch result {
            case let .success(imageFeed):
                XCTAssertEqual(imageFeed, [], "Expected empty feed")
                 
            case let .failure(error):
                XCTFail("Expected successful feed result, got \(result) instead")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }

    // MARK: Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> LocalFeedLoader {
        let storeBundle = Bundle(for: CoreDataFeedStore.self)
        let storeURL = testSpecificStoreURL
        let store = try! CoreDataFeedStore(storeURL: storeURL, bundle: storeBundle)
        let sut = LocalFeedLoader(store: store, currentDate: Date.init)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func setupEmptyStoreState() {
        deletestoreArtifact()
    }
    
    private func undoStoreSideEffects() {
        deletestoreArtifact()
    }
    
    private func deletestoreArtifact() {
        try? FileManager.default.removeItem(at: testSpecificStoreURL)
    }
    
    private var testSpecificStoreURL: URL {
        return FileManager.default.urls(for: .cachesDirectory,
                                        in: .userDomainMask).first!.appendingPathComponent("\(type(of: self )).store")
    }
    
    private func cachesDirectory() -> URL {
        return FileManager.default.urls(for: .cachesDirectory,
                                        in: .userDomainMask).first!
    }
}
