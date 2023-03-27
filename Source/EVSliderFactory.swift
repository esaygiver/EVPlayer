//
//  EVSliderFactory.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 26.03.2023.
//

import Foundation

enum EVSliderType {
    case progress
    case sound
}

final class EVSliderFactory {
    
    static func create(ofType type: EVSliderType) -> EVSliderView {
        switch type {
        case .progress:
            return EVProgressSliderView()
            
        case .sound:
            return EVSoundSliderView()
        }
    }
}
