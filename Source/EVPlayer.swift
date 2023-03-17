//
//  EVPlayer.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 14.05.2022.
//

import UIKit
import AVKit

public protocol EVPlayerDelegate: AnyObject {
    func stateDidChanged(player: AVPlayer?, to state: EVVideoState)
    func playTimeDidChanged(player: AVPlayer?, currentTime: Double, totalTime: Double, loadedRange: String)
    func fullScreenTransactionUpdate(to state: EVFullScreenState)
}

extension EVPlayerDelegate {
    func stateDidChanged(player: AVPlayer?, to state: EVVideoState) { }
    func playTimeDidChanged(player: AVPlayer?, currentTime: Double, totalTime: Double, loadedRange: String) { }
    func fullScreenTransactionUpdate(to state: EVFullScreenState) { }
}

open class EVPlayer: UIView {
    
    // MARK: - UI Properties
    
    let videoStreamView = UIView()
    let thumbnailView = EVThumbnailView()
    let coverView = EVCoverView()
    let propertiesStackView = EVPlayerPropertiesView()
    let bufferingView = EVBufferingView()
    let emptyView = EVEmptyView()
    
    // Tap Gestures
    lazy var singleTapGR = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
    lazy var doubleTapGR = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
    
    // MARK: - Logic Properties
    
    // Player
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    var playerLayer: AVPlayerLayer?
    
    // Observers
    var timeObserver: Any?
    var progressBarHighlightedObserver: NSKeyValueObservation?
    
    // Delegate
    public weak var delegate: EVPlayerDelegate?
    
    // Setup Configuration
    var configuration: EVConfiguration?
        
    // State
    lazy var videoState: EVVideoState = .empty {
        didSet {
            delegate?.stateDidChanged(player: player, to: videoState)
        }
    }
    
    // MARK: - Initializer
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        prepareForReuse()
        EVViewDefaultLogger.logger.log("EVView", type: .deinited)
    }
    
    public override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        playerLayer?.frame = bounds
    }
    
    func prepareForReuse() {
        player?.pause()
        player = nil
        playerItem = nil
        playerLayer = nil
        progressBarHighlightedObserver?.invalidate()
        progressBarHighlightedObserver = nil
        NotificationCenter.default.removeObserver(self)
        videoStreamView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        if let timeObserverToken = timeObserver {
            player?.removeTimeObserver(timeObserverToken)
            timeObserver = nil
        }
    }
}

// MARK: - Interfaces

// Implementation of EVUIProtocol
/// setup, update UI and, apply configuration
/// show & hide progress
/// forward & rewind button UI update

extension EVPlayer: EVUIProtocol { }

// Implementation of EVPlayerProtocol
/// setup playerItem, player and, playerLayer
/// seek to desired time

extension EVPlayer: EVPlayerProtocol { }

// Implementation of EVWorkerProtocol
/// load EVPlayer and create player with given url

extension EVPlayer: EVWorkerProtocol { }

// Implementation of EVObserverProtocol
/// add time & progressBar observers
/// subscribe itemDidEnd and, WillResignActive notifiacations from publishers

extension EVPlayer: EVObserverProtocol { }

// Implementation of EVStateProtocol
/// state updater
extension EVPlayer: EVStateProtocol { }


// MARK: - Delegates

// Subscribe to EVCoverViewDelegate

extension EVPlayer: EVCoverViewDelegate {
        
    func play() {
        updateState(to: videoState == .pause ? .play : .pause)
    }
    
    func rewind(_ seconds: Double) {
        guard let player = player else { return }
        
        let playerCurrentTime = CMTimeGetSeconds(player.currentTime())
        var newTime = playerCurrentTime - seconds
        
        if newTime < 0 { newTime = 0 }
        
        let cachedState = videoState
        updateState(to: .pause)
        
        let lastTime: CMTime = CMTimeMake(Int64(newTime * 1000 as Float64), 1000)
        seek(to: lastTime, continueFrom: cachedState)
                
        showOverlayAnimation(type: .rewind, seek: seconds)
    }
    
    func forward(_ seconds: Double) {
        guard let player = player,
              let duration = player.currentItem?.duration else { return }
        
        let playerCurrentTime = CMTimeGetSeconds(player.currentTime())
        let newTime = playerCurrentTime + seconds

        if newTime < (CMTimeGetSeconds(duration) + seconds) {
            
            let cachedState = videoState
            updateState(to: .pause)
            
            let lastTime: CMTime = CMTimeMake(Int64(newTime * 1000 as Float64), 1000)
            seek(to: lastTime, continueFrom: cachedState)
            
            showOverlayAnimation(type: .forward, seek: seconds)
        }
    }
    
    func volume(_ val: Float) {
        player?.volume = val
    }
    
    func restart() {
        updateState(to: .restart)
    }
    
    func fullScreen() {
        guard let config = configuration else {
            return
        }
        
        delegate?.fullScreenTransactionUpdate(to: .willEnter)
        
        var fsConfig = config
        fsConfig.initialState = videoState
        fsConfig.seekTime = player?.currentTime()
        fsConfig.isMuted = player?.isMuted
        fsConfig.volume = player?.volume
        fsConfig.videoGravity = .resizeAspect
        
        updateState(to: .pause)

        EVPlayerController.show(withConfiguration: fsConfig, presentCallback: { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.delegate?.fullScreenTransactionUpdate(to: .didEnter)

        }, willDismissCallback: { [weak self] config in
            guard let strongSelf = self else { return }

            strongSelf.applyConfiguration(config)
            strongSelf.seek(to: config.seekTime, continueFrom: config.initialState)
            
            strongSelf.delegate?.fullScreenTransactionUpdate(to: .willDismiss)

        }, didDismissCallback: { [weak self] in
            guard let strongSelf = self else { return }

            strongSelf.delegate?.fullScreenTransactionUpdate(to: .didDismiss)
        })
    }
}

// Subscribe to EVThumbnailViewDelegate

extension EVPlayer: EVThumbnailViewDelegate {
    
    func start() {
        updateState(to: .quickPlay)
    }
}

// MARK: - Gesture Handlers

extension EVPlayer {
    
    @objc
    private func handleSingleTap(sender: UITapGestureRecognizer) {
        coverView.toggleVisibility()
    }
    
    @objc
    private func handleDoubleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            
            if (sender.location(ofTouch: 0, in: videoStreamView).x + 75) < videoStreamView.bounds.midX { // Rewind
                coverView.rewindEvent()
                
            } else if sender.location(ofTouch: 0, in: videoStreamView).x > (videoStreamView.bounds.midX + 75) { // Forward
                coverView.forwardEvent()
                
            } else {
                handleSingleTap(sender: sender)
            }
        }
    }
}
