//
//  Logger.swift
//  SignalRClient
//
//  Created by Bojan Dimovski on 31/05/2019.
//  Copyright © 2019 Pawel Kadluczka. All rights reserved.
//

import Foundation
import os.log

class Logger {

	private struct Message {
		public var contents: String
		public var level: OSLogType
	}
	private var log: OSLog

	private static let shared = Logger()

	private static var bundleIdentifier = Bundle(for: Logger.self).bundleIdentifier ?? ""

	convenience init() {
		self.init(subsystem: nil, category: nil)
	}

	init(subsystem: String?, category: String?) {
		log = OSLog(subsystem: Logger.bundleIdentifier, category: category ?? "")
	}

	static func verbose(_ message: String) {
		shared.send(message: Message(contents: message, level: .info))
	}

	static func info(_ message: String) {
		shared.send(message: Message(contents: message, level: .default))
	}

	static func error(_ message: String) {
		shared.send(message: Message(contents: message, level: .error))
	}

	static func debug(_ message: String) {
		shared.send(message: Message(contents: message, level: .debug))
	}

	static func warning(_ message: String) {
		shared.send(message: Message(contents: message, level: .error))
	}

	private func send(message: Message) {
		os_log("%@", log: log, type: message.level, message.contents)
	}

}
