//
//  CacheManager.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/29/25.
//

import Foundation

/// Data structure to store cached data with timestamp
struct CachedResponse: Codable {
    let data: Data
    let timestamp: Date
}

enum CacheManager {
    private static let cacheExpirationInterval: TimeInterval = 60 * 60 * 24 // 1 day
    private static let userDefaults = UserDefaults.standard
    private static let storageKeyPrefix = "cache_"

    /// Retrieve cached data if exists and not expired
    static func getCachedData(forKey key: String) async throws -> Data? {
        let storageKey = storageKeyPrefix + key
        guard let cachedData = userDefaults.data(forKey: storageKey) else {
            return nil
        }

        let cachedResponse = try JSONDecoder().decode(CachedResponse.self, from: cachedData)

        guard Date().timeIntervalSince(cachedResponse.timestamp) < cacheExpirationInterval else {
            userDefaults.removeObject(forKey: storageKey)
            return nil
        }

        return cachedResponse.data
    }

    /// Store data in the cache (encodes the value, wraps with timestamp, stores in UserDefaults)
    static func cacheData<T: Encodable>(_ data: T, forKey key: String) async throws {
        let encodedValue = try JSONEncoder().encode(data)
        let wrapped = CachedResponse(data: encodedValue, timestamp: Date())
        let storedData = try JSONEncoder().encode(wrapped)
        userDefaults.set(storedData, forKey: storageKeyPrefix + key)
    }
}
