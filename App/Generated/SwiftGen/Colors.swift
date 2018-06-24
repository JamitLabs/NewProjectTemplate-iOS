// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  internal typealias AssetColorTypeAlias = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias AssetColorTypeAlias = UIColor
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Feedback {
    internal static let failure = ColorAsset(name: "Failure")
    internal static let success = ColorAsset(name: "Success")
    internal static let warning = ColorAsset(name: "Warning")
  }
  internal enum Text {
    internal static let darkText = ColorAsset(name: "DarkText")
    internal static let lightText = ColorAsset(name: "LightText")
  }
  internal enum Theme {
    internal static let accent = ColorAsset(name: "Accent")
    internal static let primary = ColorAsset(name: "Primary")
    internal static let secondary = ColorAsset(name: "Secondary")
  }

  // swiftlint:disable trailing_comma
  internal static let allColors: [ColorAsset] = [
    Feedback.failure,
    Feedback.success,
    Feedback.warning,
    Text.darkText,
    Text.lightText,
    Theme.accent,
    Theme.primary,
    Theme.secondary,
  ]
  // swiftlint:enable trailing_comma
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

internal extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
