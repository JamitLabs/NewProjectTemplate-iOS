//
//  Created by Cihat Gündüz on 13.02.19.
//  Copyright © 2019 Jamit Labs GmbH. All rights reserved.
//

import MungoHealer
import UIKit

var mungo: MungoHealer! // swiftlint:disable:this implicitly_unwrapped_optional

final class ErrorHandler {
    static let shared = ErrorHandler()

    func setup(window: UIWindow) {
        let errorHandler = AlertLogErrorHandler(window: window) { log.error($0) }
        mungo = MungoHealer(errorHandler: errorHandler)
    }
}
