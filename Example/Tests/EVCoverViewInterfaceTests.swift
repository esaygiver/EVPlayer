//
//  EVCoverViewInterfaceTests.swift
//  EVPlayer_Tests
//
//  Created by Emirhan Saygiver on 27.03.2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
import EVPlayer

final class EVCoverViewInterfaceTests: XCTestCase {

    var evPlayer: EVPlayer!
    var mockInterfaceApplier: MockEVPlayerInterfaceApplier!
    var sut: EVCoverViewInterface!
    
    override func setUp() {
        super.setUp()
        mockInterfaceApplier = MockEVPlayerInterfaceApplier()
        sut = mockInterfaceApplier._cover
        evPlayer = EVPlayer(frame: .zero, interfaceImpl: mockInterfaceApplier)
    }
    
    override func tearDown() {
        mockInterfaceApplier = nil
        sut = nil
        evPlayer = nil
        super.tearDown()
    }
    
    func test_checkFullScreenButtonDefaultVisibility() {
        // When
        evPlayer.updateInitialUI(with: mockConfig)
        
        // Then
        XCTAssertTrue((sut as! MockEVCoverView).isFullScreenButtonVisible)
    }
    
    func test_checkFullScreenButtonVisibilityWhenHide() {
        // Given
        mockConfig.isFullScreenModeSupported = false

        // When
        evPlayer.updateInitialUI(with: mockConfig)
        
        // Then
        XCTAssertFalse((sut as! MockEVCoverView).isFullScreenButtonVisible)
    }
    
    func test_checkNotifyPlayerEndedWhenVideoStateIsEnded() {
        // When
        evPlayer.changeState(to: .ended)
        
        // Then
        XCTAssertTrue((sut as! MockEVCoverView).isNotifyPlayerEndedTriggered)
    }

    func test_checkNotifyPlayerPlayingWhenVideoStateIsPlaying() {
        // When
        evPlayer.changeState(to: .play)
        
        // Then
        XCTAssertTrue((sut as! MockEVCoverView).isNotifyPlayerPlayingTriggered)
    }
    
    func test_checkNotifyPlayerPauseWhenVideoStateIsPause() {
        // When
        evPlayer.changeState(to: .pause)
        
        // Then
        XCTAssertTrue((sut as! MockEVCoverView).isNotifyPlayerPauseTriggered)
    }
    
    func test_changePlayButtonImageWhenBuffering() {
        // Given
        let expectation = XCTestExpectation(description: "Change play button image when buffering on main thread")
        
        // When
        evPlayer.showProgress()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            guard (self.sut as! MockEVCoverView).isPlayButtonImageChangedWhenBuffering else {
                return XCTFail("Parameter hasn't changed to true after 1 seconds")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_changePlayButtonImageWhenBufferingEnded() {
        // Given
        let expectation = XCTestExpectation(description: "Change play button image when buffer ended on main thread")
        
        // When
        evPlayer.hideProgress()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            guard (self.sut as! MockEVCoverView).isPlayButtonImageChangedWhenBufferingEnded else {
                return XCTFail("Parameter hasn't changed to true after 1 seconds")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_checkCoverVisibilityOnPauseStateWhenApplyConfiguration() {
        // Given
        mockConfig.initialState = .pause
        
        // When
        evPlayer.applyConfiguration(mockConfig)
        
        // Then
        XCTAssertTrue((self.sut as! MockEVCoverView).isVisible)
    }
    
    func test_checkCoverVisibilityOnExceptPauseStateWhenApplyConfiguration() {
        // Given
        let videoStatesExceptPause: [EVVideoState] = [
            .quickPlay, .play, .ended, .thumbnail, .restart
        ]
        
        videoStatesExceptPause
            .lazy
            .forEach { state in
                
                // When
                mockConfig.initialState = state
                self.evPlayer.applyConfiguration(mockConfig)
                
                // Then
                XCTAssertFalse((self.sut as! MockEVCoverView).isVisible)
            }
    }
    
    func test_checkVolumeHasUpdatedWhenApplyingConfiguration() {
        // Given
        let mockVolumeValue: Float = 0.6
        mockConfig.volume = mockVolumeValue
        
        // When
        evPlayer.applyConfiguration(mockConfig)
        
        // Then
        XCTAssertTrue((self.sut as! MockEVCoverView).isVolumeUpdated)
        XCTAssertNotNil((self.sut as! MockEVCoverView).updatedVolumeValue)
        XCTAssertEqual((self.sut as! MockEVCoverView).updatedVolumeValue, mockVolumeValue)
    }
    
    func test_toggleCoverVisibilityWhenSingleTapGestureTapped() {
        // When
        evPlayer.handleSingleTap()
        
        // Then
        XCTAssertTrue((self.sut as! MockEVCoverView).isVisibilityToggled)
    }
    
    func test_updateForwardDurationWhenSeekStateChanged() {
        // Given
        let mockForwardSeekTime: EVSeekDuration = .k60
        
        // When
        evPlayer.updateForwardDuration(to: mockForwardSeekTime)
        
        // Then
        XCTAssertTrue((self.sut as! MockEVCoverView).isForwardSeekDurationChanged)
        XCTAssertNotNil((self.sut as! MockEVCoverView).changedForwardSeekDuration)
        XCTAssertEqual((self.sut as! MockEVCoverView).changedForwardSeekDuration, mockForwardSeekTime)
    }
    
    func test_updateRewindDurationWhenSeekStateChanged() {
        // Given
        let mockRewindSeekTime: EVSeekDuration = .k15
        
        // When
        evPlayer.updateRewindDuration(to: mockRewindSeekTime)
        
        // Then
        XCTAssertTrue((self.sut as! MockEVCoverView).isRewindSeekDurationChanged)
        XCTAssertNotNil((self.sut as! MockEVCoverView).changedRewindSeekDuration)
        XCTAssertEqual((self.sut as! MockEVCoverView).changedRewindSeekDuration, mockRewindSeekTime)
    }
}
