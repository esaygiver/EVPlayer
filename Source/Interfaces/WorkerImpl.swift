//
//  WorkerImpl.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 12.03.2023.
//

import AVKit

public protocol EVWorkerProtocol {
    func load(with config: EVConfiguration)
    func createPlayer(with url: URL)
}

extension EVWorkerProtocol where Self: EVPlayer  {
    
    public func load(with config: EVConfiguration) {
        guard let media = config.media,
              let url = media.mediaURL else {
            updateState(to: .empty)
            EVViewDefaultLogger.logger.error("\(#function), media url is nil, check out configuration file")
            return
        }
        
        self.configuration = config

        updateForwardDuration(to: config.forwardSeekDuration)
        updateRewindDuration(to: config.rewindSeekDuration)
        thumbnailView.updateThumbnailImage(to: config.media?.thumbnailURL)
        createPlayer(with: url)
        updateState(to: config.initialState)
    }
    
    public func createPlayer(with url: URL) {
        if let avAssetFromCache = configuration?.playerCacher.asset(for: url) {
            setPlayerItem(with: avAssetFromCache)
            setPlayer()
            setPlayerLayer()
            addObservers()
            
        } else {
            let avAsset = AVAsset(url: url)
            configuration?.playerCacher.add(asset: avAsset, for: url)
            createPlayer(with: url)
        }
    }
}
