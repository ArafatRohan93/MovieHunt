//
//  AppLogger.swift
//  MovieHunt
//
//  Created by Arafat Rohan Vivasoft on 17/2/26.
//

import Foundation
import OSLog

enum LogCategory: String {
    case networking = "Networking"
    case navigation = "Navigation"
    case business = "Business"
    case storage = "Storage"
}

struct AppLogger {
    static let subsystem =
        Bundle.main.bundleIdentifier ?? "com.arafatrohan.MovieHunt"

    static func log(
        _ message: String,
        category: LogCategory,
        level: OSLogType = .debug
    ) {
        let logger = Logger(subsystem: subsystem, category: category.rawValue)

        switch level {
        case .debug:
            logger.debug("\(message, privacy: .public)")
        case .info:
            logger.info("\(message, privacy: .public)")
        case .error:
            logger.error("\(message, privacy: .public)")
        case .fault:
            logger.fault("\(message, privacy: .public)")
        default:
            logger.log("\(message, privacy: .public)")
        }
    }
}
