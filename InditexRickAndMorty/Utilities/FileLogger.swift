//
//  FileLogger.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 1/9/25.
//

import Foundation

class FileLogger {
    static let shared = FileLogger()
    private let logFileURL: URL
    
    private init() {
        let fileManager = FileManager.default
        let directory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        logFileURL = directory.appendingPathComponent("app_logs.txt")
    }
    
    func log(_ message: String) {
        let timestamp = ISO8601DateFormatter().string(from: Date())
        let fullMessage = "[\(timestamp)] \(message)\n"
        if let data = fullMessage.data(using: .utf8) {
            if FileManager.default.fileExists(atPath: logFileURL.path) {
                if let handle = try? FileHandle(forWritingTo: logFileURL) {
                    handle.seekToEndOfFile()
                    handle.write(data)
                    handle.closeFile()
                }
            } else {
                try? data.write(to: logFileURL)
            }
        }
    }
    
    func getLogFileURL() -> URL {
        return logFileURL
    }
}
