//
//  CacheManagerTests.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 7/9/25.
//

import Testing
@testable import FantasyPeek
import Foundation

/// Unit tests for the cache manager
@MainActor
@Suite("CacheManagerTests")
struct CacheManagerTests {

    struct DummyCodable: Codable, Equatable {
        let name: String
        let value: Int
    }

    // Helper method to clear cache for given key before each test
    private func clearCache(forKey key: String) {
        let keyWithPrefix = "cache_" + key
        UserDefaults.standard.removeObject(forKey: keyWithPrefix)
    }

    @Test("Caching and retrieving data before expiration")
    func testCachingAndRetrieval() async throws {
        let key = "testCache"
        clearCache(forKey: key)
        let data = DummyCodable(name: "test", value: 123)
        try await CacheManager.cacheData(data, forKey: key)
        let resultData = try await CacheManager.getCachedData(forKey: key)
        let decoded = try resultData.map { try JSONDecoder().decode(DummyCodable.self, from: $0) }
        #expect(decoded == data, "Retrieved data should match cached data")
        clearCache(forKey: key)
    }

    @Test("Data is nil after cache expiration")
    func testCacheExpiration() async throws {
        let key = "testExpiration"
        clearCache(forKey: key)
        let dummy = DummyCodable(name: "expire", value: 1)
        let encodedDummy = try JSONEncoder().encode(dummy)
        let expiredTimestamp = Date().addingTimeInterval(-60*60*25) // 25 hours ago
        let expired = CachedResponse(data: encodedDummy, timestamp: expiredTimestamp)
        let expiredData = try JSONEncoder().encode(expired)
        UserDefaults.standard.set(expiredData, forKey: "cache_" + key)
        let result = try await CacheManager.getCachedData(forKey: key)
        #expect(result == nil, "Expired cache should return nil")
        clearCache(forKey: key)
    }

    @Test("No data for uncached key")
    func testNoDataForUncachedKey() async throws {
        let key = "noDataKey"
        clearCache(forKey: key)
        let result = try await CacheManager.getCachedData(forKey: key)
        #expect(result == nil, "Should return nil for uncached key")
    }

    @Test("Proper encoding and decoding of Codable data")
    func testCodableRoundTrip() async throws {
        let key = "roundTripKey"
        clearCache(forKey: key)
        let dummy = DummyCodable(name: "round", value: 42)
        try await CacheManager.cacheData(dummy, forKey: key)
        let resultData = try await CacheManager.getCachedData(forKey: key)
        let decoded = try resultData.map { try JSONDecoder().decode(DummyCodable.self, from: $0) }
        #expect(decoded == dummy, "Decoded data should match original codable struct")
        clearCache(forKey: key)
    }

}
