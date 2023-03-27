//
//  EVPlayerMockInterfaceApplier.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 26.03.2023.
//

import EVPlayer

struct MockEVPlayerInterfaceApplier: EVPlayerInterfaceImplementation {
    
    var _thumbnail: EVThumbnailViewInterface
    var _cover: EVCoverViewInterface
    var _progress: EVProgressViewInterface
    var _buffering: EVBufferingViewInterface
    
    init(thumbnailInterface: EVThumbnailViewInterface = MockEVThumbnailView(),
         coverInterface: EVCoverViewInterface = MockEVCoverView(),
         progressInterface: EVProgressViewInterface = MockEVProgressView(),
         bufferingInterface: EVBufferingViewInterface = MockEVBufferingView()) {
        self._thumbnail = thumbnailInterface
        self._cover = coverInterface
        self._progress = progressInterface
        self._buffering = bufferingInterface
    }
}
