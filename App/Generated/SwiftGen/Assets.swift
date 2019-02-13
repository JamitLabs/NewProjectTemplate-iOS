// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
#endif

// MARK: - Asset Catalogs

internal typealias Colors = Asset.Colors
internal typealias Images = Asset.Images

internal enum Asset {
  internal enum Colors {
    internal enum Feedback {
      internal static let danger = UIColor(named: "Feedback/Danger", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let info = UIColor(named: "Feedback/Info", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let neutral = UIColor(named: "Feedback/Neutral", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let success = UIColor(named: "Feedback/Success", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let warning = UIColor(named: "Feedback/Warning", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    }
    internal enum Text {
      internal static let darkText = UIColor(named: "Text/DarkText", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let lightText = UIColor(named: "Text/LightText", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    }
    internal enum Theme {
      internal static let accent = UIColor(named: "Theme/Accent", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let primary = UIColor(named: "Theme/Primary", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let secondary = UIColor(named: "Theme/Secondary", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    }
  }
  internal enum Images {
    internal static let blubb = UIImage(named: "Blubb", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
  }
}

// MARK: - Implementation Details

private final class BundleToken {}
