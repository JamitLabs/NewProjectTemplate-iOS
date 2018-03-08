//
//  Created by Cihat Gündüz on 26.05.17.
//  Copyright © 2017 Jamit Labs GmbH. All rights reserved.
//

import SwiftyBeaver
import UIKit

let log = SwiftyBeaver.self

class Logger {
    // MARK: - Stored Type Properties
    static let shared = Logger()

    // MARK: - Instance Properties
    func setup() {
        // configure console logging
        let consoleDestination = ConsoleDestination()
        #if DEBUG
            consoleDestination.minLevel = .debug
        #else
            consoleDestination.minLevel = .warning
        #endif
        log.addDestination(consoleDestination)

        // configure file logging
        let fileDestination = FileDestination()
        fileDestination.minLevel = .info
        log.addDestination(fileDestination)
    }
}
