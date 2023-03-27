//
//  EVUIImpl.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 12.03.2023.
//

import UIKit
import AVKit

public protocol EVUIBufferingImpl {
    func showProgress()
    func hideProgress()
}

public protocol EVUIPropertyUpdater {
    func updateForwardDuration(to state: EVSeekDuration)
    func updateRewindDuration(to state: EVSeekDuration)
    func updateProgressTintColor(with config: EVConfiguration)
}

public protocol EVUIConfigApplier {
    func applyConfiguration(_ configuration: EVConfiguration?)
}

public protocol EVUIOverlayImpl {
    func showOverlayAnimation(type: EVOverlayType, seek duration: Double)
}

public typealias EVUIProtocolType = EVUIBufferingImpl & EVUIPropertyUpdater & EVUIConfigApplier & EVUIOverlayImpl

public protocol EVUIProtocol: EVUIProtocolType {
    func updateInitialUI(with config: EVConfiguration)
    func updateUI(with progressTime: CMTime?)
}

extension EVUIProtocol where Self: EVPlayer {
        
    // MARK: - EVUIProtocol functions
    
    public func updateInitialUI(with config: EVConfiguration) {
        thumbnailInterface.updateThumbnailImage(to: config.media.thumbnailURL, contentMode: config.thumbnailContentMode)

        updateForwardDuration(to: config.forwardSeekDuration)
        updateRewindDuration(to: config.rewindSeekDuration)
        updateProgressTintColor(with: config)
        
        if !config.isFullScreenModeSupported { coverInterface.hideFullScreenButton() }
        
        updateState(to: config.initialState)
    }
    
    public func updateUI(with progressTime: CMTime?) {
        
        if videoState == .play {
            thumbnailInterface.isVisible = false
            progressInterface.isHidden = false
        }
        
        guard let duration = player?.currentItem?.duration,
              let progressTime = progressTime else {
            return
        }
                
        if progressTime <= duration {
            progressInterface.updateDuration(current: progressTime, total: duration)
        } else {
            progressInterface.updateDuration(current: duration, total: duration)
            updateState(to: .ended)
        }

        let progressValue = (progressTime.seconds / duration.seconds) * 100

        if let progressValueWithOneCharAfterComma = Double(String(format: "%.1f", progressValue)) {
            delegate?.evPlayer(timeChangedTo: progressTime.seconds,
                               totalTime: duration.seconds,
                               loadedRange: progressValueWithOneCharAfterComma)
        }
    }
    
    // MARK: - EVUIConfigApplier functions
    
    public func applyConfiguration(_ configuration: EVConfiguration?) {
        guard let config = configuration else {
            return
        }
                
        config.initialState != .pause ? coverInterface.hide() : coverInterface.visible()
                
        player?.isMuted = config.isMuted ?? false
        
        if let volume = config.volume {
            player?.volume = volume
            coverInterface.updateVolumeUI(for: volume)
        }
    }
    
    // MARK: - EVUIOverlayImpl functions
    
    public func showOverlayAnimation(type: EVOverlayType, seek duration: Double) {
        
        guard configuration?.isSeekAnimationsEnabled ?? true else {
            return
        }
        
        let overlayView = EVOverlayView(frame: CGRect(x: 0, y: 0,
                                                      width: videoLayer.frame.width / 3.5,
                                                      height: videoLayer.frame.height),
                                        type: type)
 
        videoLayer.addSubview(overlayView)

        overlayView.cuiPinTopToSuperView()
        overlayView.cuiPinBottomToSuperView()
        overlayView.widthAnchor.cuiSet(to: videoLayer.frame.width / 3.5)
        
        switch type {
        case .forward:
            overlayView.cuiPinTrailingToSuperView()
        case .rewind:
            overlayView.cuiPinLeadingToSuperView()
        default:
            break
        }
        
        overlayView.show(seekDuration: duration)
    }
    
    // MARK: - EVUIPropertyUpdater functions
    
    public func updateRewindDuration(to state: EVSeekDuration) {
        coverInterface.updateRewindDuration(to: state)
    }
    
    public func updateForwardDuration(to state: EVSeekDuration) {
        coverInterface.updateForwardDuration(to: state)
    }
    
    public func updateProgressTintColor(with config: EVConfiguration) {
        progressInterface.minimumTrackTintColor = config.progressBarMinimumTrackTintColor
        progressInterface.maximumTrackTintColor = config.progressBarMaximumTrackTintColor
    }
    
    // MARK: - EVUIBufferingImpl functions
    
    public func showProgress() {
        DispatchQueue.main.async {
            self.coverInterface.changePlayButtonImageForBufferState()
            self.bringSubviewToFront(self.bufferingInterface as! UIView)
            self.bufferingInterface.show()
        }
    }
    
    public func hideProgress() {
        DispatchQueue.main.async {
            self.sendSubviewToBack(self.bufferingInterface as! UIView)
            self.bufferingInterface.hide { [weak self] in
                self?.coverInterface.changePlayButtonImageForLoadedState()
            }
        }
    }
}

// MARK: - Internal functions

extension EVPlayer {
    
    func setupUI() {
        
        // Video stream layer
        addSubview(videoLayer)
        videoLayer.backgroundColor = .black
        videoLayer.isUserInteractionEnabled = true
        videoLayer.cuiPinToSuperview()
        
        // EVThumbnailView
        if let thumbnailView = thumbnailInterface as? EVThumbnailView {
            addSubview(thumbnailView)
            thumbnailView.isHidden = true
            thumbnailView.delegate = self
            thumbnailView.cuiPinToSuperview()
        }
        
        // EVCoverView
        if let coverView = coverInterface as? EVCoverView {
            addSubview(coverView)
            coverView.delegate = self
            coverView.cuiPinToSuperview()
        }
        
        // EVProgressView
        if let progressView = progressInterface as? EVProgressView {
            addSubview(progressView)
            progressView.cuiPinLeadingToSuperView(constant: 12)
            progressView.cuiPinTrailingToSuperView(constant: -12)
            progressView.cuiPinBottomToSuperView()
            progressView.heightAnchor.cuiSet(to: 25)
        }

        // EVBufferingView
        if let bufferingView = bufferingInterface as? EVBufferingView {
            addSubview(bufferingView)
            bufferingView.cuiCenterInSuperview()
            bufferingView.heightAnchor.cuiSet(to: 40)
            bufferingView.widthAnchor.cuiSet(to: 40)
        }
        
        setGestureRecognizers()
    }
    
    func setGestureRecognizers() {
        singleTapGR.numberOfTapsRequired = 1
        videoLayer.addGestureRecognizer(singleTapGR)
        
        doubleTapGR.numberOfTapsRequired = 2
        videoLayer.addGestureRecognizer(doubleTapGR)
        
        singleTapGR.require(toFail: doubleTapGR)
    }
    
    // Gesture Handlers
    
    @objc
    public func handleSingleTap() {
        coverInterface.toggleVisibility()
    }
    
    @objc
    public func handleDoubleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            
            if (sender.location(ofTouch: 0, in: videoLayer).x + 75) < videoLayer.bounds.midX { // Rewind
                coverInterface.rewindEvent()
                
            } else if sender.location(ofTouch: 0, in: videoLayer).x > (videoLayer.bounds.midX + 75) { // Forward
                coverInterface.forwardEvent()
                
            } else {
                handleSingleTap()
            }
        }
    }
}
