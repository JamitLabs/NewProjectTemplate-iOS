//
//  Created by Jamit Labs on 16.07.18.
//  Copyright © 2018 Jamit Labs GmbH. All rights reserved.
//

import Foundation

extension RangeReplaceableCollection where Self: MutableCollection {
    /// Removes from the collection all elements that satisfy the given predicate.
    ///
    /// - Parameter predicate: A closure that takes an element of the
    ///   sequence as its argument and returns a Boolean value indicating
    ///   whether the element should be removed from the collection.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    mutating func removeAll(where predicate: (Element) throws -> Bool) rethrows {
        if var outerIndex = try index(where: predicate) {
            var innerIndex = index(after: outerIndex)

            while innerIndex != endIndex {
                if try !predicate(self[innerIndex]) {
                    swapAt(outerIndex, innerIndex)
                    formIndex(after: &outerIndex)
                }

                formIndex(after: &innerIndex)
            }

            removeSubrange(outerIndex...)
        }
    }
}

extension RangeReplaceableCollection {
    /// Removes from the collection all elements that satisfy the given predicate.
    ///
    /// - Parameter predicate: A closure that takes an element of the
    ///   sequence as its argument and returns a Boolean value indicating
    ///   whether the element should be removed from the collection.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    mutating func removeAll(where predicate: (Element) throws -> Bool) rethrows {
        // TODO: Switch to using RRC.filter once stdlib is compiled for 4.0
        // self = try filter { try !predicate($0) }
        self = try Self(self.lazy.filter { try !predicate($0) })
    }
}
