//
//  SharedTestHelpers.swift
//  PracticeFeedTests
//
//  Created by Chowdhury Md Rajib Sarwar on 11/18/24.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}

