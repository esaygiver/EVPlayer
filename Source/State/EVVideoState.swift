//
//  EVVideoState.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 8.03.2023.
//

import Foundation

public enum EVVideoState {
    
    /// Thumbnail view will shown at first,
    /// Loading starts
    /// After player is ready thumbnail view will hidden
    case quickPlay
    
    case play
    
    case pause
    
    /// Thumbnail view will shown at top with play button
    case thumbnail
    
    /// Update cover layer, shows restart button
    case ended
    
    case restart
    
    /// Empty view will top if url is empty
    case empty
}
