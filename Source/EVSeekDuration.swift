//
//  EVSeekDuration.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 17.03.2023.
//

import UIKit

public enum EVSeekDuration {
    case k5
    case k10
    case k15
    case k30
    case k45
    case k60
    case k75
    case k90
    
    var value: Double {
        switch self {
        case .k5:   return 5
        case .k10:  return 10
        case .k15:  return 15
        case .k30:  return 30
        case .k45:  return 45
        case .k60:  return 60
        case .k75:  return 75
        case .k90:  return 90
        }
    }
    
    var forwardImage: UIImage? {
        switch self {
        case .k5:   return Constants.Icons.forwardImage5
        case .k10:  return Constants.Icons.forwardImage10
        case .k15:  return Constants.Icons.forwardImage15
        case .k30:  return Constants.Icons.forwardImage30
        case .k45:  return Constants.Icons.forwardImage45
        case .k60:  return Constants.Icons.forwardImage60
        case .k75:  return Constants.Icons.forwardImage75
        case .k90:  return Constants.Icons.forwardImage90
        }
    }
    
    var rewindImage: UIImage? {
        switch self {
        case .k5:   return Constants.Icons.rewindImage5
        case .k10:  return Constants.Icons.rewindImage10
        case .k15:  return Constants.Icons.rewindImage15
        case .k30:  return Constants.Icons.rewindImage30
        case .k45:  return Constants.Icons.rewindImage45
        case .k60:  return Constants.Icons.rewindImage60
        case .k75:  return Constants.Icons.rewindImage75
        case .k90:  return Constants.Icons.rewindImage90
        }
    }
    
}
