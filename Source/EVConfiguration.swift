//
//  EVViewConfiguration.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 8.03.2023.
//

import Foundation
import AVKit

public protocol EVConfigurationInterface {
    var media: EVMediaInterface? { get }
    var initialState: EVVideoState? { get }
    var context: EVTransactionContextInterface? { get }
    
    var shouldAutoPlay: Bool { get }
    var shouldLoopVideo: Bool { get }
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
    public let media: EVMediaInterface?
    public var initialState: EVVideoState?
    public var context: EVTransactionContextInterface?
    public var seekTime: CMTime?
    public var isMuted: Bool?
    public var volume: Float?
    public var assetCacher: EVPlayerCacheability = EVPlayerCache.shared
    
    // MARK: - Initializer
    
    public init(media: EVMediaInterface? = nil,
                state: EVVideoState? = .thumbnail,
                context: EVTransactionContextInterface? = nil) {
        
        self.initialState = state
        self.media = media
        self.context = context
        self.seekTime = context?.seekTime
        self.isMuted = context?.isMuted
        self.volume = context?.volume
    }
    
    /// Set auto play status, default is true
    public var shouldAutoPlay: Bool = false {
        didSet {
            initialState = .quickPlay
        }
    }
    
    /// Restart video when playback did end, default is false
    public var shouldLoopVideo: Bool = false
    
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
