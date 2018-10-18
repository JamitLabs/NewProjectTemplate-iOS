// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import UIKit

// MARK: - Helpers
private final class BundleToken {}

extension UIImage {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  convenience init(name: String) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: name, in: bundle, compatibleWith: nil)!
    #elseif os(watchOS)
    self.init(named: name)!
    #endif
  }
}

// MARK: - Images
enum Image {

  static let allImages: [UIImage] = [
  ]
}
