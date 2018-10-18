// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import UIKit

// MARK: - Helpers
private final class BundleToken {}

extension UIColor {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init(name: String) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: name, in: bundle, compatibleWith: nil)!
    #elseif os(watchOS)
    self.init(named: name)!
    #endif
  }
}

// MARK: - Colors
enum Color {
  enum Feedback {
    static let failure = UIColor(name: "Failure")
    static let success = UIColor(name: "Success")
    static let warning = UIColor(name: "Warning")
  }
  enum Text {
    static let darkText = UIColor(name: "DarkText")
    static let lightText = UIColor(name: "LightText")
  }
  enum Theme {
    static let accent = UIColor(name: "Accent")
    static let primary = UIColor(name: "Primary")
    static let secondary = UIColor(name: "Secondary")
  }

  static let allColors: [UIColor] = [
    Feedback.failure,
    Feedback.success,
    Feedback.warning,
    Text.darkText,
    Text.lightText,
    Theme.accent,
    Theme.primary,
    Theme.secondary,
  ]
}
