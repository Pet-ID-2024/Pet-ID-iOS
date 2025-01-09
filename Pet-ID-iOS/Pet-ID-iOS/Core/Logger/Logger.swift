//
//  Logger.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import CocoaLumberjack
import Then

extension DDLogFlag {
  public var level: String {
    switch self {
    case DDLogFlag.error: return "❤️ ERROR"
    case DDLogFlag.warning: return "💛 WARNING"
    case DDLogFlag.info: return "💙 INFO"
    case DDLogFlag.debug: return "💚 DEBUG"
    case DDLogFlag.verbose: return "💜 VERBOSE"
    default: return "☠️ UNKNOWN"
    }
  }
}

private class LogFormatter: NSObject, DDLogFormatter {

  static let dateFormatter = DateFormatter().then {
    $0.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
  }

  public func format(message logMessage: DDLogMessage) -> String? {
    let timestamp = LogFormatter.dateFormatter.string(from: logMessage.timestamp)
    let level = logMessage.flag.level
    let filename = logMessage.fileName
    let function = logMessage.function ?? ""
    let line = logMessage.line
    let message = logMessage.message.components(separatedBy: "\n").joined(separator: "\n    ")
    return "\(timestamp) \(level) \(filename).\(function):\(line) - \(message)"
  }

  private func formattedDate(from date: Date) -> String {
    return LogFormatter.dateFormatter.string(from: date)
  }

}

let log = Logger()

final class Logger {

  // MARK: Initialize

  init() {
    setenv("XcodeColors", "YES", 0)
    
    DDTTYLogger.sharedInstance?.do {
      $0.logFormatter = LogFormatter()
      $0.colorsEnabled = false /*true*/ // Note: doesn't work in Xcode 8
      $0.setForegroundColor(DDMakeColor(30, 121, 214), backgroundColor: nil, for: .info)
      $0.setForegroundColor(DDMakeColor(50, 143, 72), backgroundColor: nil, for: .debug)
      DDLog.add($0)
    }

    // File logger
//    DDFileLogger().do {
//      $0.rollingFrequency = TimeInterval(60 * 60 * 24)  // 24 hours
//      $0.logFileManager.maximumNumberOfLogFiles = 7
//      DDLog.add($0)
//    }
      
       // 커스텀 로그 디렉토리 설정
              let customLogDirectory = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
              let fileManager = DDLogFileManagerDefault(logsDirectory: customLogDirectory)
              
              // 파일 로그 설정
              let fileLogger = DDFileLogger(logFileManager: fileManager).then {
                  $0.rollingFrequency = TimeInterval(60 * 60 * 24) // 24시간
                  $0.logFileManager.maximumNumberOfLogFiles = 7
              }
              
              DDLog.add(fileLogger)
              
              // 디렉토리 경로 출력 및 확인
              print("✅ 로그 디렉토리: \(fileManager.logsDirectory)")
  }


  // MARK: Logging

  func error(
    _ items: Any...,
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line
  ) {
    let message = self.message(from: items)
    DDLogError(message, file: file, function: function, line: line)
  }

  func warning(
    _ items: Any...,
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line
  ) {
    let message = self.message(from: items)
    DDLogWarn(message, file: file, function: function, line: line)
  }

  func info(
    _ items: Any...,
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line
  ) {
    let message = self.message(from: items)
    DDLogInfo(message, file: file, function: function, line: line)
  }

  func debug(
    _ items: Any...,
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line
  ) {
    let message = self.message(from: items)
    DDLogDebug(message, file: file, function: function, line: line)
  }

  func verbose(
    _ items: Any...,
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line
  ) {
    let message = self.message(from: items)
    DDLogVerbose(message, file: file, function: function, line: line)
  }


  // MARK: Utils

  private func message(from items: [Any]) -> String {
    return items
      .map { String(describing: $0) }
      .joined(separator: " ")
  }

}
