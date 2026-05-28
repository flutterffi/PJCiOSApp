import OSLog

protocol AppLogging {
    func info(_ message: String)
    func error(_ message: String)
}

struct AppLogger: AppLogging {
    private let logger: Logger

    init(subsystem: String, category: String = "App") {
        self.logger = Logger(subsystem: subsystem, category: category)
    }

    func info(_ message: String) {
        logger.info("\(message, privacy: .public)")
    }

    func error(_ message: String) {
        logger.error("\(message, privacy: .public)")
    }
}
