//
//  Created by Cihat Gündüz on 26.05.17.
//  Copyright © 2017 Jamit Labs GmbH. All rights reserved.
//

import HandyUIKit
import JGProgressHUD
import UIKit

class Progress {
    // MARK: - Stored Type Properties
    static let shared = Progress()

    // MARK: - Stored Instance Properties
    private var currentProgressHUD: JGProgressHUD?

    // MARK: - Instance Methods
    func show(in view: UIView, message: String? = nil) {
        hideIfNeeded()
        currentProgressHUD = JGProgressHUD(style: .extraLight)
        currentProgressHUD?.interactionType = .blockAllTouches
        currentProgressHUD?.textLabel.text = message
        currentProgressHUD?.backgroundColor = UIColor.black.change(.alpha, to: 0.3)
        currentProgressHUD?.show(in: view)
    }

    func hideIfNeeded() {
        currentProgressHUD?.dismiss()
        currentProgressHUD = nil
    }
}
