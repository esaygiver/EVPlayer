//
//  EVViewLogger.swift
//  EVPlayer
//
//  Created by Emirhan Saygiver on 28.02.2023.
//

import Foundation

enum LogType {
    case deinited
    case none
}

/// Represents a class will log events.
protocol EVViewLogger {
    
    /// Whether to log or not
    var log: Bool { get set }
    
    // MARK: Methods

    /// Normal log messages
    /// - parameter message: The message being logged.
    func log(_ message: @autoclosure () -> String, type: LogType)

    /// Error Messages
    /// - parameter message: The message being logged.
    func error(_ message: @autoclosure () -> String)
}

extension EVViewLogger {
    
    /// Default implementation.
    func log(_ message: @autoclosure () -> String, type: LogType = .none) {
        guard log else { return }
        
        guard type == .none else {
            abstractLog("DEINIT", message: message())
            return
        }
        
        abstractLog("LOG", message: message())
    }

    /// Default implementation.
    func error(_ message: @autoclosure () -> String) {
        abstractLog("ERROR", message: message())
    }

    private func abstractLog(_ logType: String, message: @autoclosure () -> String) {
        NSLog("\(logType) from EVViewLogger: %@", message())
    }
}
