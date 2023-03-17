//
//  EVMedia.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 22.02.2023.
//

import Foundation

public struct EVMedia {
    let mediaURL: URL?
    let thumbnailURL: URL?
    
    public init(mediaURL: URL?, thumbnailURL: URL? = nil) {
        self.mediaURL = mediaURL
        self.thumbnailURL = thumbnailURL
    }
}
