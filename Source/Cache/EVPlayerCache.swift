//
//  EVPlayerCache.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 22.02.2023.
//

import AVKit

public protocol EVPlayerCacheability {
    var cache: [String : AVAsset] { get set }
    func add(asset: AVAsset, for url: URL)
    func asset(for url: URL) -> AVAsset?
}

public final class EVPlayerCache {

    public static let shared = EVPlayerCache()

    public var cache = [String: AVAsset]()
}

// MARK: - Implementation of EVPlayerCacheability

extension EVPlayerCache: EVPlayerCacheability {
    
    public func add(asset: AVAsset, for url: URL) {
        cache[url.absoluteString] = asset
    }

    public func asset(for url: URL) -> AVAsset? {
        cache[url.absoluteString]
    }
}
