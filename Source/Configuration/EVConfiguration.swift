//
//  EVViewConfiguration.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 8.03.2023.
//

import Foundation
import AVKit

public enum EVSeekDuration {
    case k5
    case k10
    case k15
    case k30
    case k45
    case k60
    case k75
    case k90
    
    var value: Double {
        switch self {
        case .k5:   return 5
        case .k10:  return 10
        case .k15:  return 15
        case .k30:  return 30
        case .k45:  return 45
        case .k60:  return 60
        case .k75:  return 75
        case .k90:  return 90
        }
    }
    var forwardImage: UIImage? {
        switch self {
        case .k5:   return Constants.Icons.forwardImage5
        case .k10:  return Constants.Icons.forwardImage10
        case .k15:  return Constants.Icons.forwardImage15
        case .k30:  return Constants.Icons.forwardImage30
        case .k45:  return Constants.Icons.forwardImage45
        case .k60:  return Constants.Icons.forwardImage60
        case .k75:  return Constants.Icons.forwardImage75
        case .k90:  return Constants.Icons.forwardImage90
        }
    }
    
    var rewindImage: UIImage? {
        switch self {
        case .k5:   return Constants.Icons.rewindImage5
        case .k10:  return Constants.Icons.rewindImage10
        case .k15:  return Constants.Icons.rewindImage15
        case .k30:  return Constants.Icons.rewindImage30
        case .k45:  return Constants.Icons.rewindImage45
        case .k60:  return Constants.Icons.rewindImage60
        case .k75:  return Constants.Icons.rewindImage75
        case .k90:  return Constants.Icons.rewindImage90
        }
    }
}

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
    var playerCacher: EVPlayerCacheability { get }
}

public struct EVConfiguration: EVConfigurationInterface {
    public let media: EVMedia?
    public var initialState: EVVideoState?
    public var seekTime: CMTime?
    public var isMuted: Bool?
    public var volume: Float?
    
    /// Cache url assets and improves reuse
    public var playerCacher: EVPlayerCacheability
    
    /// Has single and double tap events
    public var gestureOrganizer: EVTapGestureOrganizerImpl
    
    // MARK: - Initializer
    
    public init(media: EVMedia? = nil,
                initialState: EVVideoState? = nil,
                seekTime: CMTime? = nil,
                isMuted: Bool? = nil,
                volume: Float? = nil,
                playerCacher: EVPlayerCacheability = EVPlayerCache.shared,
                gestureOrganizer: EVTapGestureOrganizerImpl = EVTapGestureOrganizer()) {
        
        self.initialState = initialState
        self.media = media
        self.seekTime = seekTime
        self.isMuted = isMuted
        self.volume = volume
        self.playerCacher = playerCacher
        self.gestureOrganizer = gestureOrganizer
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
