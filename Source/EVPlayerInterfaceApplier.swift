//
//  EVPlayerInterfaceApplier.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 22.03.2023.
//

import Foundation

public struct EVPlayerInterfaceApplier: EVPlayerInterfaceImplementation {
    
    public var _thumbnail: EVThumbnailViewInterface
    public var _cover: EVCoverViewInterface
    public var _progress: EVProgressViewInterface
    public var _buffering: EVBufferingViewInterface
    
    public init(thumbnailInterface: EVThumbnailViewInterface = EVThumbnailView(),
                coverInterface: EVCoverViewInterface = EVCoverView(),
                progressInterface: EVProgressViewInterface = EVProgressView(),
                bufferingInterface: EVBufferingViewInterface = EVBufferingView()) {
        self._thumbnail = thumbnailInterface
        self._cover = coverInterface
        self._progress = progressInterface
        self._buffering = bufferingInterface
    }
}
