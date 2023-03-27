//
//  EVPlayerInterfaceImpl.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 22.03.2023.
//

import Foundation

public protocol EVPlayerInterfaceImplementation {
    var _thumbnail: EVThumbnailViewInterface { get }
    var _cover: EVCoverViewInterface { get }
    var _progress: EVProgressViewInterface { get }
    var _buffering: EVBufferingViewInterface { get }
    
    init(thumbnailInterface: EVThumbnailViewInterface,
         coverInterface: EVCoverViewInterface,
         progressInterface: EVProgressViewInterface,
         bufferingInterface: EVBufferingViewInterface)
}
