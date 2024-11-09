//
//  RemoteFeedLoaderTests.swift
//  PracticeFeedTests
//
//  Created by Chowdhury Md Rajib Sarwar on 11/7/24.
//

import XCTest
import PracticeFeed

final class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let (client, _) = makeSUT()
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        let (client, sut) = makeSUT(url: url)
        
        sut.load() { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestDataFromURLTwice() {
        let url = URL(string: "https://a-given-url.com")!
        let (client, sut) = makeSUT(url: url)
        
        sut.load() { _ in }
        sut.load() { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (client, sut) = makeSUT()

        expect(sut, toCompleteWith: .failure(.connectivity)) {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        }
    }
    
    func test_load_deliversErrorOnNon200HTTPResponse() {
        let (client, sut) = makeSUT()
         
        let samples = [199, 201, 300, 400, 500]
        
        samples.enumerated().forEach { index, code in
            expect(sut, toCompleteWith: .failure(.invalidData)) {
                client.complete(withStatusCode: code, at: index)
            }
        }
    }
    
    func test_load_deliversErrorOn200HTTPResponseOnInvalidJSON() {
        let (client, sut) = makeSUT()
         
        expect(sut, toCompleteWith: .failure(.invalidData)) {
            let ivalidJSON = Data("invalid data".utf8)
            client.complete(withStatusCode: 200, data: ivalidJSON)
        }
    }
    
    func test_load_deliversErrorOn200HTTPResponseOnEmptyJSONList() {
        let (client, sut) = makeSUT()
         
        expect(sut, toCompleteWith: .success([])) {
            let emptyListJSON = Data("{\"items\": []}".utf8)
            client.complete(withStatusCode: 200, data: emptyListJSON)
        }
    }

    // MARK: Helpers
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (client: HTTPClientSpy, sut: RemoteFeedLoader){
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (client, sut)
    }
    
    private func expect(_ sut: RemoteFeedLoader, toCompleteWith result: RemoteFeedLoader.Result, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        var captureResults = [RemoteFeedLoader.Result]()
        sut.load { captureResults.append($0) }
                
        action()
        
        XCTAssertEqual(captureResults, [result], file: file, line: line)
    }
    
    private class HTTPClientSpy: HTTPClient {
        private var messages = [(url: URL, completion: (HTTPClientResult) -> Void)]()
        
        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }
        
        func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            messages.append((url, completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(.failure(error))
        }
        
        func complete(withStatusCode code: Int, data: Data = Data(), at index: Int = 0) {
            let response = HTTPURLResponse(url: requestedURLs[index], statusCode: code, httpVersion: nil, headerFields: nil)!
            messages[index].completion(.success(data, response))
        }
    }
}
