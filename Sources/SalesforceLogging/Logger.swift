//
//  Logger.swift
//  MobileExtensionSDK
//
//  Created by Alex Sikora on 10/1/19.
//

import Foundation

/// Defines the severity levels for log messages
///
/// Log levels are used to categorize messages based on their importance and to
/// control which messages are displayed in different environments.
public enum LogLevel {
    /// Critical errors that cause application failure or unexpected behavior
    /// These are always shown in all environments and should be addressed immediately
    case error
    
    /// Potential issues or unexpected situations that don't cause immediate failure
    /// but might indicate problems or lead to errors if not addressed
    case warning
    
    /// General information about application flow, user actions, or state changes
    /// Useful for understanding the application's behavior and tracking important events
    case info
    
    /// Detailed information for debugging purposes
    /// Only displayed in debug builds and development environments
    case debug
}

/// A logging interface for console and remote logs
///
/// The Logger protocol provides a standardized way for plugins to emit log messages
/// to the consuming application's logging system. The host application is responsible
/// for:
/// - Formatting log messages with appropriate prefixes
/// - Filtering logs based on environment settings
/// - Directing logs to appropriate destinations (console, file, remote service)
/// - Adding any additional context (timestamps, thread info, etc.)
public protocol Logger {

    /// Sends a log message to the host application's logging system
    ///
    /// Messages sent through this method will be prefixed with the plugin's name
    /// in the consuming application to help identify the source of the log.
    ///
    /// - Parameters:
    ///   - logMessage: The message content to log
    ///   - level: The severity level of the log message, which affects how and where it's displayed
    func log(_ logMessage: String, level: LogLevel)
}
