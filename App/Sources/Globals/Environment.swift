// Copyright © 2019 Jamit Labs GmbH. All rights reserved.

import Foundation

enum Environment {
    case production
    case staging
    case development

    static var current: Environment = {
        #if DEVELOPMENT
            return .development
        #elseif STAGING
            return .staging
        #else
            return .production
        #endif
    }()
}
