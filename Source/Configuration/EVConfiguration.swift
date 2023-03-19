//
//  EVViewConfiguration.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 8.03.2023.
//

import Foundation
import AVKit

public protocol EVConfigurationInterface {
    var media: EVMedia? { get }
    var initialState: EVVideoState? { get }
    var seekTime: CMTime? { get }
    var isMuted: Bool? { get }
    var volume: Float? { get }
    
    var forwardSeekDuration: EVSeekDuration { get }
    var rewindSeekDuration: EVSeekDuration { get }
    var videoGravity: AVLayerVideoGravity { get }
    var isFullScreenShouldAutoRotate: Bool { get }
    var fullScreenSupportedInterfaceOrientations: UIInterfaceOrientationMask { get }
    var isFullScreenShouldOpenWithLandscapeMode: Bool { get }
    var fullScreenPresentationStyle: UIModalPresentationStyle { get }
    var isSeekAnimationsEnabled: Bool { get }
    var isTransactionAnimated: Bool { get }
    var assetCacher: EVPlayerCacheability { get }
}

public struct EVConfiguration: EVConfigurationInterface {
    public let media: EVMedia?
    public var initialState: EVVideoState?
    public var seekTime: CMTime?
    public var isMuted: Bool?
    public var volume: Float?
    
    /// Cache url assets and improves reuse
    public var assetCacher: EVPlayerCacheability
    
    // MARK: - Initializer
    
    public init(media: EVMedia? = nil,
                initialState: EVVideoState? = nil,
                seekTime: CMTime? = nil,
                isMuted: Bool? = nil,
                volume: Float? = nil,
                playerCacher: EVPlayerCacheability = EVPlayerCache.shared) {
        
        self.initialState = initialState
        self.media = media
        self.seekTime = seekTime
        self.isMuted = isMuted
        self.volume = volume
        self.assetCacher = playerCacher
    }
    
    /// Seek forward player value, the default is 10 sec
    public var forwardSeekDuration: EVSeekDuration = .k10
    
    /// Rewind forward player value, the default is 10 sec
    public var rewindSeekDuration: EVSeekDuration = .k10

    /// The default value is AVLayerVideoGravity.resize
    public var videoGravity: AVLayerVideoGravity = .resize
    
    /// The default value is true
    public var isFullScreenShouldAutoRotate: Bool = true
    
    /// The default value is UIInterfaceOrientationMask.allButUpsideDown
    public var fullScreenSupportedInterfaceOrientations: UIInterfaceOrientationMask = .allButUpsideDown
    
    /// If you want to display full screen in landscape mode, set this parameter to true. Otherwise, full screen will be display in portrait mode.
    /// The default value is false
    public var isFullScreenShouldOpenWithLandscapeMode: Bool = false
    
    /// The default value is UIModalPresentationStyle.fullScreen
    public var fullScreenPresentationStyle: UIModalPresentationStyle = .fullScreen
    
    /// The default value is true
    public var isSeekAnimationsEnabled: Bool = true
    
    /// The default value is true
    public var isTransactionAnimated: Bool = true
    
}
