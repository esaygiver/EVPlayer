//
//  EVViewDefaultLogger.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 28.02.2023.
//

import Foundation

struct EVViewDefaultLogger: EVViewLogger {
    
    static var logger: EVViewLogger = EVViewDefaultLogger()
    
    public var log: Bool = true
}
