//
//  EVMedia.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 22.02.2023.
//

import Foundation

public protocol EVMediaInterface {
    var videoURL: URL { get }
    var thumbnailURL: URL? { get }
    init(videoURL: URL, thumbnailURL: URL?)
}

public struct EVMedia: EVMediaInterface {
    public let videoURL: URL
    public let thumbnailURL: URL?
    
    public init(videoURL: URL, thumbnailURL: URL? = nil) {
        self.videoURL = videoURL
        self.thumbnailURL = thumbnailURL
    }
}
