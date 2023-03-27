//
//  EVBufferingViewInterfaceTests.swift
//  EVPlayer_Tests
//
//  Created by Emirhan Saygiver on 27.03.2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
import EVPlayer

final class EVBufferingViewInterfaceTests: XCTestCase {

    var evPlayer: EVPlayer!
    var mockInterfaceApplier: MockEVPlayerInterfaceApplier!
    var sut: EVBufferingViewInterface!
    
    override func setUp() {
        super.setUp()
        mockInterfaceApplier = MockEVPlayerInterfaceApplier()
        sut = mockInterfaceApplier._buffering
        evPlayer = EVPlayer(frame: .zero, interfaceImpl: mockInterfaceApplier)
    }
    
    override func tearDown() {
        mockInterfaceApplier = nil
        sut = nil
        evPlayer = nil
        super.tearDown()
    }

    func testBufferingInterfaceVisibleWhenShowProgressCalled() {
        // Given
        let expectation = XCTestExpectation(description: "Show progress on main thread")
        
        // When
        evPlayer.showProgress()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            guard (self.sut as! MockEVBufferingView).isBufferingInterfaceVisible else {
                return XCTFail("Parameter hasn't changed to true after 1 seconds")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testBufferingInterfaceVisibleWhenVideoStateIsPlay() {
        // Given
        let expectation = XCTestExpectation(description: "Show progress on main thread")
        
        // When
        evPlayer.changeState(to: .play)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            guard (self.sut as! MockEVBufferingView).isBufferingInterfaceVisible else {
                return XCTFail("Parameter hasn't changed to true after 1 seconds")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testBufferingInterfaceVisibleWhenHideProgressCalled() {
        // Given
        let expectation = XCTestExpectation(description: "Hide progress on main thread")
        
        // When
        evPlayer.hideProgress()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            guard !(self.sut as! MockEVBufferingView).isBufferingInterfaceVisible else {
                return XCTFail("Parameter hasn't changed to true after 1 seconds")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testBufferingInterfaceVisibleWhenVideoStateIsPause() {
        // Given
        let expectation = XCTestExpectation(description: "Show progress on main thread")
        
        // When
        evPlayer.changeState(to: .pause)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            guard !(self.sut as! MockEVBufferingView).isBufferingInterfaceVisible else {
                return XCTFail("Parameter hasn't changed to true after 1 seconds")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
}
