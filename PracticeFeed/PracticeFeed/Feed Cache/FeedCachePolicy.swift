//
//  FeedCachePolicy.swift
//  PracticeFeed
//
//  Created by Chowdhury Md Rajib Sarwar on 11/18/24.
//

import Foundation

final class FeedCachePolicy {
    private init() {}
    
    private static let calender = Calendar(identifier: .gregorian)
   
    private static var maxCacheAgeInDays: Int {
        return 7
    }
    
    static func validate(_ timestamp: Date, against date: Date) -> Bool {
        guard let maxCacheAge = calender.date(byAdding: .day, value: maxCacheAgeInDays, to: timestamp) else {
            return false
        }
        
        return date < maxCacheAge
    }
}
