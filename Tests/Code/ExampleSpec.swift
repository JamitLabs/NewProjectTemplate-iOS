//
//  Created by Cihat Gündüz on 26.05.17.
//  Copyright © 2017 Jamit Labs GmbH. All rights reserved.
//

@testable import NewProjectTemplate
import Nimble
import Quick
import UIKit

class ExampleSpec: QuickSpec {
    override func spec() {
        describe("multiplication") {
            it("works with small numbers") {
                expect(2 * 2) == 4
            }

            it("works with big numbers") {
                expect(2_000 * 2_000) == 4_000_000
            }
        }

        // Add your tests here, see https://github.com/Quick/Quick for more details
    }
}
