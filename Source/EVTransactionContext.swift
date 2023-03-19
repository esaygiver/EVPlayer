//
//  EVTransactionContext.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 20.03.2023.
//

import AVKit

public protocol EVTransactionContextInterface {
    var seekTime: CMTime? { get }
    var isMuted: Bool? { get }
    var volume: Float? { get }
}

public struct EVTransactionContext: EVTransactionContextInterface {
    public var seekTime: CMTime?
    public var isMuted: Bool?
    public var volume: Float?
    
    // MARK: - Initializer
    
    public init(seekTime: CMTime?,
                isMuted: Bool?,
                volume: Float?) {
        
        self.seekTime = seekTime
        self.isMuted = isMuted
        self.volume = volume
    }
}
