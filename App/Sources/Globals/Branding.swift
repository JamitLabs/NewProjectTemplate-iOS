//
//  Created by Cihat Gündüz on 26.05.17.
//  Copyright © 2017 Jamit Labs GmbH. All rights reserved.
//

import UIKit

class Branding {
    // MARK: - Stored Type Properties
    static let shared: Branding = Branding()

    // MARK: - Instance Methods
    func setupGlobalAppearance() {
        UIView.appearance().tintColor = Color.Theme.accent
    }
}
