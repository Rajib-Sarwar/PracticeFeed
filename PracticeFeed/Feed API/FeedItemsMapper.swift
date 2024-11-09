//
//  FeedItemsMapper.swift
//  PracticeFeed
//
//  Created by Chowdhury Md Rajib Sarwar on 11/9/24.
//

import Foundation

internal final class FeedItemsMapper {
    private struct Root: Decodable {
        let items: [Item]
        
        var feed: [FeedItem] {
            return items.map { $0.item }
        }
    }

    private struct Item: Decodable {
        let id: UUID
        let description: String?
        let location: String?
        let image: URL
        
        var item: FeedItem {
            return FeedItem(id: id, description: description, location: location, imageURL: image)
        }
       
    }
    
    private static var OK_200: Int { return 200 }
    
    internal static func map(_ response: HTTPURLResponse, _ data: Data) throws -> [FeedItem] {
        
        
        let root = try JSONDecoder().decode(Root.self, from: data)
        return root.items.map { $0.item }
    }
    
    
    
    internal static func map(_ data: Data, from response: HTTPURLResponse) -> RemoteFeedLoader.Result {
        guard response.statusCode == OK_200,
              let root = try? JSONDecoder().decode(Root.self, from: data) else {
            return .failure(.invalidData)
        }
        
        return .success(root.feed)
        
    }
}


