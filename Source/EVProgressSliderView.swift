//
//  EVProgressSliderView.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 20.03.2023.
//

import UIKit

final class EVProgressSliderView: EVSliderView {
    
    var _minimumTrackTintColor: UIColor? = .orange {
        didSet {
            minimumTrackTintColor = _minimumTrackTintColor
        }
    }
    
    var _maximumTrackTintColor: UIColor? = .lightGray.withAlphaComponent(0.8) {
        didSet {
            maximumTrackTintColor = _maximumTrackTintColor
        }
    }
    
    override func setup() {
        isContinuous = false
        value = 0
        thumbTintColor = .white
        setThumbImage(makeSliderImage(size: CGSize(width: 14, height: 14)), for: .normal)
        setThumbImage(makeSliderImage(size: CGSize(width: 18, height: 18)), for: .highlighted)
        
        super.setup()
    }
}
