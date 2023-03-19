//
//  UIImpl.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 12.03.2023.
//

import UIKit
import AVKit

protocol EVUIBufferingImpl {
    func showProgress()
    func hideProgress()
}

protocol EVUIPropertyUpdater {
    func updateForwardDuration(to state: EVSeekDuration)
    func updateRewindDuration(to state: EVSeekDuration)
}

protocol EVUIConfigApplier {
    func applyConfiguration(_ configuration: EVConfiguration?)
}

protocol EVUIOverlayImpl {
    func showOverlayAnimation(type: EVOverlayType, seek duration: Double)
}

protocol EVUITapGestureApplier {
    func setGestureRecognizers()
}

typealias EVUIProtocolType = EVUIBufferingImpl & EVUIPropertyUpdater & EVUIConfigApplier & EVUIOverlayImpl & EVUITapGestureApplier

protocol EVUIProtocol: EVUIProtocolType {
    func setupUI()
    func updateUI(with progressTime: CMTime?)
}

extension EVUIProtocol where Self: EVPlayer {
        
    func setupUI() {
        // Video stream layer
        addSubview(videoLayer)
        videoLayer.backgroundColor = .black
        videoLayer.isUserInteractionEnabled = true
        videoLayer.cuiPinToSuperview()
        
        // thumbnailView
        addSubview(thumbnailView)
        thumbnailView.isHidden = true
        thumbnailView.delegate = self
        thumbnailView.cuiPinToSuperview()
        
        // coverView
        addSubview(coverView)
        coverView.delegate = self
        coverView.cuiPinToSuperview()
        
        // propertiesStackView
        addSubview(propertiesStackView)
        propertiesStackView.cuiPinLeadingToSuperView(constant: 12)
        propertiesStackView.cuiPinTrailingToSuperView(constant: -12)
        propertiesStackView.cuiPinBottomToSuperView()
        propertiesStackView.heightAnchor.cuiSet(to: 25)
        
        // bufferingView
        addSubview(bufferingView)
        bufferingView.cuiCenterInSuperview()
        bufferingView.heightAnchor.cuiSet(to: 40)
        bufferingView.widthAnchor.cuiSet(to: 40)
        
        // emptyView
        addSubview(emptyView)
        emptyView.cuiPinToSuperview()
        emptyView.backgroundColor = .black
        emptyView.isHidden = true
        
        // Tap Gesture Recognizers

        setGestureRecognizers()
    }
    
    func updateUI(with progressTime: CMTime?) {
        
        if videoState == .play || videoState == .quickPlay {
            thumbnailView.isHidden = true
            propertiesStackView.isHidden = false
            hideProgress()
        }
        
        guard let duration = player?.currentItem?.duration,
              let progressTime = progressTime else {
            return
        }
        
        let progressValue = (progressTime.seconds / duration.seconds) * 100
        
        propertiesStackView.updateDuration(current: progressTime <= duration ? progressTime : duration, total: duration)

        if let progressValueWithOneCharAfterComma = Double(String(format: "%.1f", progressValue)) {
            delegate?.evPlayer(timeChangedTo: progressTime.seconds,
                               totalTime: duration.seconds,
                               loadedRange: progressValueWithOneCharAfterComma)
        }
    }
    
    func applyConfiguration(_ configuration: EVConfiguration?) {
        guard let config = configuration else {
            return
        }
                
        config.initialState != .pause ? coverView.hide() : coverView.visible()
                
        player?.isMuted = config.isMuted ?? false
        
        if let volume = config.volume {
            player?.volume = volume
            coverView.updateVolumeUI(for: volume)
        }
    }
    
    func showOverlayAnimation(type: EVOverlayType, seek duration: Double) {
        
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
    
    func updateRewindDuration(to state: EVSeekDuration) {
        coverView.updateRewindButton(to: state)
    }
    
    func updateForwardDuration(to state: EVSeekDuration) {
        coverView.updateForwardDuration(to: state)
    }
    
    func showProgress() {
        DispatchQueue.main.async {
            self.coverView.changePlayButtonImageForBufferState()
            self.bringSubview(toFront: self.bufferingView)
            self.bufferingView.show()
        }
    }
    
    func hideProgress() {
        DispatchQueue.main.async {
            self.sendSubview(toBack: self.bufferingView)
            self.bufferingView.hide { [weak self] in
                self?.coverView.changePlayButtonImageForLoadedState()
            }
        }
    }
    
    func setGestureRecognizers() {
        singleTapGR.numberOfTapsRequired = 1
        videoLayer.addGestureRecognizer(singleTapGR)
        
        doubleTapGR.numberOfTapsRequired = 2
        videoLayer.addGestureRecognizer(doubleTapGR)
        
        singleTapGR.require(toFail: doubleTapGR)
    }
}
