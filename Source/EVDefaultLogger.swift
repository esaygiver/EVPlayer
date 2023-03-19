//
//  EVDefaultLogger.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 28.02.2023.
//

import Foundation

struct EVDefaultLogger: EVPlayerLogger {
    
    static var logger: EVPlayerLogger = EVDefaultLogger()
    
    public var log: Bool = true
}
