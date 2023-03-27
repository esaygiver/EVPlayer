//
//  MockEVCoverView.swift
//  EVPlayer_Tests
//
//  Created by Emirhan Saygiver on 27.03.2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import EVPlayer

final class MockEVCoverView: EVCoverViewType {
    
    var isFullScreenButtonVisible = true
    var isNotifyPlayerEndedTriggered = false
    var isNotifyPlayerPlayingTriggered = false
    var isNotifyPlayerPauseTriggered = false
    var isPlayButtonImageChangedWhenBufferingEnded = false
    var isPlayButtonImageChangedWhenBuffering = false
    var isVisible = false
    var isVisibilityToggled = false
    var isForwardSeekDurationChanged = false
    var changedForwardSeekDuration: EVSeekDuration?
    var isRewindSeekDurationChanged = false
    var changedRewindSeekDuration: EVSeekDuration?
    var isVolumeUpdated = false
    var updatedVolumeValue: Float?
    
    func hideFullScreenButton() {
        isFullScreenButtonVisible = false
    }
    
    func notifyPlayerEnded() {
        isNotifyPlayerEndedTriggered = true
    }
    
    func notifyPlayerPlaying() {
        isNotifyPlayerPlayingTriggered = true
    }
    
    func notifyPlayerPause() {
        isNotifyPlayerPauseTriggered = true
    }
    
    func changePlayButtonImageForBufferState() {
        isPlayButtonImageChangedWhenBuffering = true
    }
    
    func changePlayButtonImageForLoadedState() {
        isPlayButtonImageChangedWhenBufferingEnded = true
    }
    
    func visible() {
        isVisible = true
    }
    
    func hide() {
        isVisible = false
    }
    
    func toggleVisibility() {
        isVisibilityToggled = true
    }
    
    func updateForwardDuration(to state: EVSeekDuration) {
        isForwardSeekDurationChanged = true
        changedForwardSeekDuration = state
    }
    
    func updateRewindDuration(to state: EVSeekDuration) {
        isRewindSeekDurationChanged = true
        changedRewindSeekDuration = state
    }

    func updateVolumeUI(for volume: Float) {
        isVolumeUpdated = true
        updatedVolumeValue = volume
    }
    
    func rewindEvent() { }
    
    func forwardEvent() { }
}
