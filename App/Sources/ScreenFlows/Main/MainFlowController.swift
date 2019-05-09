// Copyright © 2019 Jamit Labs GmbH. All rights reserved.

import Imperio
import UIKit

class MainFlowController: InitialFlowController {
    var mainViewCtrl: MainViewController?

    override func start(from window: UIWindow) {
        mainViewCtrl = StoryboardScene.Main.initialScene.instantiate()
        mainViewCtrl?.flowDelegate = self
        window.rootViewController = mainViewCtrl
    }
}

extension MainFlowController: MainFlowDelegate {
    // TODO: not yet implemented
}
