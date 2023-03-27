//
//  EVProgressViewInterfaceTests.swift
//  EVPlayer_Tests
//
//  Created by Emirhan Saygiver on 27.03.2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
import AVKit
import EVPlayer

final class EVProgressViewInterfaceTests: XCTestCase {

    var evPlayer: EVPlayer!
    var mockInterfaceApplier: MockEVPlayerInterfaceApplier!
    var sut: EVProgressViewInterface!
    
    override func setUp() {
        super.setUp()
        mockInterfaceApplier = MockEVPlayerInterfaceApplier()
        sut = mockInterfaceApplier._progress
        evPlayer = EVPlayer(frame: .zero, interfaceImpl: mockInterfaceApplier)
    }
    
    override func tearDown() {
        mockInterfaceApplier = nil
        sut = nil
        evPlayer = nil
        super.tearDown()
    }
    
    func testVisibleState() {
        // When
        evPlayer.makePlayerPropertiesVisible()
        
        // Then
        XCTAssertTrue((sut as! MockEVProgressView).isVisible)
    }
    
    func testVisibilityStateToHide() {
        // When
        evPlayer.hideCover()
        
        // Then
        XCTAssertFalse((sut as! MockEVProgressView).isVisible)
    }
    
    func testChangeMinimumTrackTintColor() {
        // Given
        mockConfig.progressBarMinimumTrackTintColor = .black
        
        // When
        evPlayer.updateProgressTintColor(with: mockConfig)
        
        // Then
        XCTAssertNotNil((sut as! MockEVProgressView).minimumTrackTintColor)
        XCTAssertEqual((sut as! MockEVProgressView).minimumTrackTintColor, .black)
    }
    
    func testChangeMaximumTrackTintColor() {
        // Given
        mockConfig.progressBarMaximumTrackTintColor = .white
        
        // When
        evPlayer.updateProgressTintColor(with: mockConfig)
        
        // Then
        XCTAssertNotNil((sut as! MockEVProgressView).maximumTrackTintColor)
        XCTAssertEqual((sut as! MockEVProgressView).maximumTrackTintColor, .white)
    }
    
    func testIsNilTimeUpdatedUI() {
        // When
        evPlayer.updateUI(with: nil)

        // Then
        XCTAssertFalse((sut as! MockEVProgressView).isDurationUpdated)
    }
    
    func testIs10SecUpdateUI() {
        // Given
        evPlayer.load(with: mockConfig)

        // When
        let tenSecondsTime = CMTimeMake(value: 10, timescale: 1)
        evPlayer.updateUI(with: tenSecondsTime)

        // Then
        XCTAssertNotNil((sut as! MockEVProgressView).currentDuration)
        XCTAssertEqual((sut as! MockEVProgressView).currentDuration, tenSecondsTime)
        XCTAssertTrue((sut as! MockEVProgressView).isDurationUpdated)
        
        // When
        let twentySecondsTime = CMTimeMake(value: 20, timescale: 1)
        evPlayer.updateUI(with: twentySecondsTime)
        
        // Then
        XCTAssertNotNil((sut as! MockEVProgressView).currentDuration)
        XCTAssertEqual((sut as! MockEVProgressView).currentDuration, twentySecondsTime)
        XCTAssertTrue((sut as! MockEVProgressView).isDurationUpdated)
    }
    
    func testIs20SecUpdateUI() {
        // Given
        evPlayer.load(with: mockConfig)

        // When
        let twentySecondsTime = CMTimeMake(value: 20, timescale: 1)
        evPlayer.updateUI(with: twentySecondsTime)
        
        // Then
        XCTAssertNotNil((sut as! MockEVProgressView).currentDuration)
        XCTAssertEqual((sut as! MockEVProgressView).currentDuration, twentySecondsTime)
        XCTAssertTrue((sut as! MockEVProgressView).isDurationUpdated)
    }
}
