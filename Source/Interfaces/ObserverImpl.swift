//
//  ObserverImpl.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 12.03.2023.
//

import AVKit

protocol EVObserverProtocol {
    func setObservers()
    func setTimeObserver()
    func setProgressBarValueChangedObserver()
    func addAVPlayerItemDidPlayToEndTimeNotification()
    func addWillResignActiveNotification()
}

extension EVObserverProtocol where Self: EVPlayer {
    
    func setObservers() {
        setTimeObserver()
        setProgressBarValueChangedObserver()
        addAVPlayerItemDidPlayToEndTimeNotification()
        addWillResignActiveNotification()
    }
    
    func setTimeObserver() {
        guard let player = player else { return }
        
        let timeInterval = CMTime(seconds: 1, preferredTimescale: 1)
        
        timeObserver = player.addPeriodicTimeObserver(forInterval: timeInterval, queue: .main, using: { [weak self] progressTime in
            guard let strongSelf = self else { return }
            
            if let currentItem = strongSelf.playerItem,
               currentItem.status == .readyToPlay {

                if currentItem.isPlaybackLikelyToKeepUp {
                    strongSelf.hideProgress()
                    strongSelf.updateUI(with: progressTime)
                } else {
                    strongSelf.showProgress()
                }
            }
        })
    }
    
    func setProgressBarValueChangedObserver() {
        progressBarHighlightedObserver = propertiesStackView.videoSlider.observe(\EVSliderView.isTracking, options: [.old, .new]) { [weak self] (_, change) in
            guard let strongSelf = self else { return }
            
            if let duration = strongSelf.player?.currentItem?.duration {
                let totalSeconds: Float64 = CMTimeGetSeconds(duration)
                let value = Float64(strongSelf.propertiesStackView.videoSlider.value) * totalSeconds
                let seekTime = CMTime(value: Int64(value), timescale: 1)
                                
                if let isValueStartedToChanging = change.newValue, isValueStartedToChanging {
                    strongSelf.player?.pause()
                    strongSelf.updateUI(with: seekTime)

                } else {
                    // value changed
                    strongSelf.seek(to: seekTime)
                    
                    let lastState = strongSelf.videoState
                    
                    // Video ended, but bar value changed
                    if lastState == .ended {
                        strongSelf.updateState(to: .pause)
                        return
                    }
                    
                    strongSelf.updateState(to: lastState)
                }
            }
        }
    }
    
    func addAVPlayerItemDidPlayToEndTimeNotification() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem, queue: .main) { [weak self] _ in
            guard let strongSelf = self else { return }
            
            strongSelf.updateState(to: .ended)
        }
    }
    
    func addWillResignActiveNotification() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationWillResignActive, object: nil, queue: .main) { [weak self] _ in
            guard let strongSelf = self else { return }
            
            strongSelf.updateState(to: .pause)
        }
    }
}
