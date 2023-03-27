//
//  EVStateImpl.swift
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
            thumbnailInterface.makePlayButtonHidden()
            updateState(to: .play)
            
        case .play:
            showProgress()
            coverInterface.notifyPlayerPlaying()
            player?.play()
            
        case .pause:
            hideProgress()
            coverInterface.notifyPlayerPause()
            player?.pause()
            
        case .thumbnail:
            updateState(to: .pause)
            bringSubviewToFront(thumbnailInterface as! UIView)
            thumbnailInterface.isVisible = true
            
        case .ended:
            coverInterface.notifyPlayerEnded()
            
        case .restart:
            seek(to: .zero, continueFrom: .play)
        }
    }
}
