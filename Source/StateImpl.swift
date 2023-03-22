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
            updateState(to: .thumbnail)
            thumbnailView.makePlayButtonHidden()
            updateState(to: .play)
            
        case .play:
            showProgress()
            coverView.notifyPlayerPlaying()
            player?.play()
            
        case .pause:
            hideProgress()
            coverView.notifyPlayerPause()
            player?.pause()
            
        case .thumbnail:
            updateState(to: .pause)
            bringSubviewToFront(thumbnailView)
            thumbnailView.isHidden = false
            propertiesStackView.isHidden = true
            
        case .ended:
            coverView.notifyPlayerEnded()
            
        case .restart:
            seek(to: .zero, continueFrom: .play)
        }
    }
}
