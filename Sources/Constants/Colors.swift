// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  typealias Color = UIColor
#elseif os(OSX)
  import AppKit.NSColor
  typealias Color = NSColor
#endif

// swiftlint:disable operator_usage_whitespace
extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
// swiftlint:enable operator_usage_whitespace

// swiftlint:disable file_length
// swiftlint:disable line_length

// swiftlint:disable type_body_length
enum ColorName {
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffa500"></span>
  /// Alpha: 100% <br/> (0xffa500ff)
  case accent
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  case darkText
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ff0000"></span>
  /// Alpha: 100% <br/> (0xff0000ff)
  case failure
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#000000"></span>
  /// Alpha: 100% <br/> (0x000000ff)
  case lightText
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#000000"></span>
  /// Alpha: 100% <br/> (0x000000ff)
  case primary
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#0000ff"></span>
  /// Alpha: 100% <br/> (0x0000ffff)
  case secondary
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#00ff00"></span>
  /// Alpha: 100% <br/> (0x00ff00ff)
  case success
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffff00"></span>
  /// Alpha: 100% <br/> (0xffff00ff)
  case warning

  var rgbaValue: UInt32 {
    switch self {
    case .accent:
      return 0xffa500ff
    case .darkText:
      return 0xffffffff
    case .failure:
      return 0xff0000ff
    case .lightText:
      return 0x000000ff
    case .primary:
      return 0x000000ff
    case .secondary:
      return 0x0000ffff
    case .success:
      return 0x00ff00ff
    case .warning:
      return 0xffff00ff
    }
  }

  var color: Color {
    return Color(named: self)
  }
}
// swiftlint:enable type_body_length

extension Color {
  convenience init(named name: ColorName) {
    self.init(rgbaValue: name.rgbaValue)
  }
}
// swiftlint:enable file_length
// swiftlint:enable line_length
