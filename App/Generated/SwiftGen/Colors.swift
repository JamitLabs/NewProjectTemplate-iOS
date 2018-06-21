// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable operator_usage_whitespace
internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
// swiftlint:enable operator_usage_whitespace

// swiftlint:disable identifier_name line_length type_body_length
internal struct ColorName {
  internal let rgbaValue: UInt32
  internal var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffa500"></span>
  /// Alpha: 100% <br/> (0xffa500ff)
  internal static let accent = ColorName(rgbaValue: 0xffa500ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#000000"></span>
  /// Alpha: 100% <br/> (0x000000ff)
  internal static let darkText = ColorName(rgbaValue: 0x000000ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ff0000"></span>
  /// Alpha: 100% <br/> (0xff0000ff)
  internal static let failure = ColorName(rgbaValue: 0xff0000ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  internal static let lightText = ColorName(rgbaValue: 0xffffffff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#000000"></span>
  /// Alpha: 100% <br/> (0x000000ff)
  internal static let primary = ColorName(rgbaValue: 0x000000ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#0000ff"></span>
  /// Alpha: 100% <br/> (0x0000ffff)
  internal static let secondary = ColorName(rgbaValue: 0x0000ffff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#00ff00"></span>
  /// Alpha: 100% <br/> (0x00ff00ff)
  internal static let success = ColorName(rgbaValue: 0x00ff00ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffff00"></span>
  /// Alpha: 100% <br/> (0xffff00ff)
  internal static let warning = ColorName(rgbaValue: 0xffff00ff)
}
// swiftlint:enable identifier_name line_length type_body_length

internal extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
