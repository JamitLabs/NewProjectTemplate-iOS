//
//  ExampleSpec.swift
//  NewProjectTemplate
//
//  Created by Cihat Gündüz on 26.05.17.
//  Copyright © 2017 Jamit Labs GmbH. All rights reserved.
//

import UIKit
import Quick
import Nimble

@testable import NewProjectTemplate

class ExampleSpec: QuickSpec {
    override func spec() {
        describe("multiplication") {
            it("works with small numbers") {
                expect(2 * 2).to(equal(4))
            }

            it("works with big numbers") {
                expect(2_000 * 2_000).to(equal(4_000_000))
            }
        }

        // Add your tests here, see https://github.com/Quick/Quick for more details
    }
}
