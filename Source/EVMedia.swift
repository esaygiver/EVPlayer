//
//  EVMedia.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 22.02.2023.
//

import Foundation

public protocol EVMediaInterface {
    var mediaURL: URL? { get }
    var thumbnailURL: URL? { get }
    init(mediaURL: URL?, thumbnailURL: URL?)
}

public struct EVMedia: EVMediaInterface {
    public let mediaURL: URL?
    public let thumbnailURL: URL?
    
    public init(mediaURL: URL?, thumbnailURL: URL? = nil) {
        self.mediaURL = mediaURL
        self.thumbnailURL = thumbnailURL
    }
}
