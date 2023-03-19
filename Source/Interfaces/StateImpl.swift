//
//  StateImpl.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 12.03.2023.
//

import Foundation
import AVKit

protocol EVStateProtocol {
    func updateState(to state: EVVideoState?)
}

extension EVStateProtocol where Self: EVPlayer {
    
    func updateState(to state: EVVideoState?) {
        guard let state = state else {
            return
        }
        
        videoState = state
        
        switch state {
        case .quickPlay:
            thumbnailView.makePlayButtonHidden()
            updateState(to: .thumbnail)
            showProgress()
            updateState(to: .play)
            
        case .play:
            coverView.notifyPlayerPlaying()
            player?.play()
            
        case .pause:
            hideProgress()
            coverView.notifyPlayerPause()
            player?.pause()
            
        case .thumbnail:
            updateState(to: .pause)
            bringSubview(toFront: thumbnailView)
            thumbnailView.isHidden = false
            propertiesStackView.isHidden = true
            
        case .ended:
            coverView.notifyPlayerEnded()
            
        case .restart:
            seek(to: kCMTimeZero, continueFrom: .play)
        
        case .empty:
            emptyView.isHidden = false
        }
    }
}
