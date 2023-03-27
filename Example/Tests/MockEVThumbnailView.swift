//
//  MockEVThumbnailView.swift
//  EVPlayer_Example
//
//  Created by Emirhan Saygiver on 26.03.2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import EVPlayer

final class MockEVThumbnailView: EVThumbnailViewType {
    
    public var isVisible: Bool = false
        
    public var isPlayButtonHidden = false
    
    public func makePlayButtonHidden() {
        isPlayButtonHidden = true
    }
    
    public var isThumbnailImageUpdated = false
    public var thumbnailImageURL: URL?
    public var thumbnailImageContentMode: UIView.ContentMode = .scaleAspectFit
    
    public func updateThumbnailImage(to url: URL?, contentMode: UIView.ContentMode) {
        isThumbnailImageUpdated = true
        thumbnailImageURL = url
        thumbnailImageContentMode = contentMode
    }
}
