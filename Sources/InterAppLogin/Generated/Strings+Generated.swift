// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum InterAppLoginLocalizable {
  internal enum Localizable {
    /// loco:684003a81687be54da004145
    internal static let buttonCreateAccount = InterAppLoginLocalizable.tr("Localizable", "buttonCreateAccount", fallback: "Create an account")
    /// loco:6840035e1687be54da004142
    internal static let buttonLogin = InterAppLoginLocalizable.tr("Localizable", "buttonLogin", fallback: "Login")
    /// loco:68404629d6574c876e05b382
    internal static let buttonUseOtherAccount = InterAppLoginLocalizable.tr("Localizable", "buttonUseOtherAccount", fallback: "Use another account")
    /// loco:684044c80031d880680d8e12
    internal static let selectAccountPanelTitle = InterAppLoginLocalizable.tr("Localizable", "selectAccountPanelTitle", fallback: "Select one or multiple accounts")
  }
  internal enum PluralLocalizable {
    /// Plural format key: "%#@value@"
    internal static func buttonContinueWithAccounts(_ p1: Int) -> String {
      return InterAppLoginLocalizable.tr("PluralLocalizable", "buttonContinueWithAccounts", p1, fallback: "Plural format key: \"%#@value@\"")
    }
    /// Plural format key: "%#@value@"
    internal static func selectedAccountCountLabel(_ p1: Int) -> String {
      return InterAppLoginLocalizable.tr("PluralLocalizable", "selectedAccountCountLabel", p1, fallback: "Plural format key: \"%#@value@\"")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension InterAppLoginLocalizable {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
