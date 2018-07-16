//
//  Created by Jamit Labs on 16.07.18.
//  Copyright © 2018 Jamit Labs GmbH. All rights reserved.
//

import Foundation

extension Bool {
    /// Equivalent to `someBool = !someBool`
    ///
    /// Useful when operating on long chains:
    ///
    ///    myVar.prop1.prop2.enabled.toggle()
    mutating func toggle() {
        self = !self // swiftlint:disable:this toggle_bool
    }
}
