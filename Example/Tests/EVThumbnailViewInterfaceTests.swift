//
//  EVThumbnailViewInterfaceTests.swift
//  EVPlayer_Tests
//
//  Created by Emirhan Saygiver on 26.03.2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
import EVPlayer

final class EVThumbnailViewInterfaceTests: XCTestCase {

    var evPlayer: EVPlayer!
    var mockInterfaceApplier: MockEVPlayerInterfaceApplier!
    var sut: EVThumbnailViewInterface!
    
    override func setUp() {
        super.setUp()
        mockInterfaceApplier = MockEVPlayerInterfaceApplier()
        sut = mockInterfaceApplier._thumbnail
        evPlayer = EVPlayer(frame: .zero, interfaceImpl: mockInterfaceApplier)
    }
    
    override func tearDown() {
        mockInterfaceApplier = nil
        sut = nil
        evPlayer = nil
        super.tearDown()
    }
    
    func testThumbnailVisibilityOnThumbnailState() {
        // When
        evPlayer.changeState(to: .thumbnail)
        
        // Then
        XCTAssertTrue((sut as! MockEVThumbnailView).isVisible)
    }
    
    func testThumbnailVisibilityWhenVideoReadyToPlay() {
        // Given
        evPlayer.changeState(to: .play)
        
        // When
        evPlayer.updateUI(with: nil)
        
        // Then
        XCTAssertFalse((sut as! MockEVThumbnailView).isVisible)
    }
    
    func testThumbnailVisibilityWhenVideoNotReadyToPlay() {
        // Given
        evPlayer.changeState(to: .thumbnail)
        
        // When
        evPlayer.updateUI(with: nil)
        
        // Then
        XCTAssertTrue((sut as! MockEVThumbnailView).isVisible)
    }
    
    func testVideoQuickPlayStatePlayButtonBehavior() {
        // Given
        evPlayer.changeState(to: .thumbnail)
        XCTAssertFalse((sut as! MockEVThumbnailView).isPlayButtonHidden)
        
        // When
        evPlayer.changeState(to: .quickPlay)
        
        // Then
        XCTAssertTrue((sut as! MockEVThumbnailView).isPlayButtonHidden)
    }
    
    func testThumbnailImageUpdateWhenLaunch() {
        // When
        evPlayer.updateInitialUI(with: mockConfig)
        
        // Then
        XCTAssertTrue((sut as! MockEVThumbnailView).isThumbnailImageUpdated)
        XCTAssertNotNil((sut as! MockEVThumbnailView).thumbnailImageURL)
        XCTAssertEqual((sut as! MockEVThumbnailView).thumbnailImageURL,
                       mockMedia.thumbnailURL)
        XCTAssertEqual((sut as! MockEVThumbnailView).contentMode, mockConfig.thumbnailContentMode)
    }

}
