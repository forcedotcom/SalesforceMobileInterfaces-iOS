//
//  Cache.swift
//  MobileExtensionSDK
//
//  Created by Radha Patnayakuni on 5/17/19.
//

import Foundation

/// Error types that can be thrown by cache operations
public enum CacheError: Error {
    /// Indicates the data being operated on is invalid or corrupted
    case invalidData
    /// Indicates an invalid or malformed key was provided
    case invalidKey
    /// Indicates the requested operation is not supported or inappropriate
    case invalidOperation
}

/// This is the primary Caching protocol for consuming applications to implement and pass in to SPI implementations.
/// The Cache protocol allows plugins to utilize the caching library of the consuming application to perform cache
/// operations against the current user's data.
///
/// Implementations should handle thread safety, storage mechanisms, and appropriate error handling.
/// Cache operations are performed asynchronously using Swift's structured concurrency.
///
/// Note: This protocol is a work in progress and future iterations may include per-user cache instances
/// and additional functionality.
public protocol Cache {
    
    /// Saves data to the cache using the specified key
    ///
    /// - Parameters:
    ///   - data: The data to save to the cache
    ///   - key: A unique identifier to associate with the data
    /// - Throws: `CacheError.invalidData` if the data cannot be saved
    ///           `CacheError.invalidKey` if the key is invalid
    ///           Any other implementation-specific errors
    func save(_ data: Data, key: String) async throws
    
    /// Loads data from the cache using the specified key
    ///
    /// - Parameter key: The unique identifier associated with the requested data
    /// - Returns: The data if found in the cache, or nil if no data exists for the key
    /// - Throws: `CacheError.invalidKey` if the key is invalid
    ///           Any other implementation-specific errors
    func load(_ key: String) async throws -> Data?
    
    /// Removes data from the cache for the specified key
    ///
    /// - Parameter key: The unique identifier of the data to remove
    /// - Throws: `CacheError.invalidKey` if the key is invalid
    ///           Any other implementation-specific errors
    func remove(_ key: String) async throws
    
    /// Clears all data from the cache
    ///
    /// This operation removes all cached items regardless of key.
    /// Implementations should ensure this operation is performed atomically when possible.
    /// - Throws: Any implementation-specific errors
    func removeAll() async throws
}
