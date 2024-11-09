//
//  HTTPClient.swift
//  PracticeFeed
//
//  Created by Chowdhury Md Rajib Sarwar on 11/9/24.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
