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
        guard let media = config.media else {
            EVDefaultLogger.logger.error("\(#function), media is nil")
            return
        }
        
        configuration = config

        createPlayer(with: media.videoURL)

        updateInitialUI(with: config)
    }
    
    public func createPlayer(with url: URL) {
        if let avAssetFromCache = configuration?.assetCacher.asset(for: url) {
            setPlayerItem(with: avAssetFromCache)
            setPlayer()
            setPlayerLayer()
            setObservers()
            
        } else {
            let avAsset = AVAsset(url: url)
            configuration?.assetCacher.add(asset: avAsset, for: url)
            createPlayer(with: url)
        }
    }
}
