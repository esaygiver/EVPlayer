//
//  EVMedia.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 22.02.2023.
//

import Foundation

public struct EVMedia {
    public let videoURL: URL
    public let thumbnailURL: URL?
    
    public init(videoURL: URL, thumbnailURL: URL? = nil) {
        self.videoURL = videoURL
        self.thumbnailURL = thumbnailURL
    }
}
