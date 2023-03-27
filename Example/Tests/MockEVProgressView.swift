//
//  MockEVProgressView.swift
//  EVPlayer_Tests
//
//  Created by Emirhan Saygiver on 27.03.2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import AVKit
import EVPlayer

final class MockEVProgressView: EVProgressViewType {
    
    var isVisible = false
    var isDurationUpdated = false
    var currentDuration: CMTime? = nil
    var minimumTrackTintColor: UIColor? = nil
    var maximumTrackTintColor: UIColor? = nil

    func makeVisibleWithAnimation() {
        isVisible = true
    }
    
    func hideWithAnimation() {
        isVisible = false
    }
    
    func updateDuration(current: CMTime, total: CMTime) {
        isDurationUpdated = true
        currentDuration = current
    }
}
