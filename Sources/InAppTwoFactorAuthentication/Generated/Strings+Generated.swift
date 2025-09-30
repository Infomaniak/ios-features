// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Localizable {
  /// loco:68d52770d78cd0b5b102a952
  internal static let twoFactorAuthJustNowLabel = Localizable.tr("Localizable", " twoFactorAuthJustNowLabel", fallback: "Just now")
  /// loco:68d4f859fceae6b843046de7
  internal static let buttonApprove = Localizable.tr("Localizable", "buttonApprove", fallback: "Approve")
  /// loco:68d4f873098af73894089853
  internal static let buttonDeny = Localizable.tr("Localizable", "buttonDeny", fallback: "Deny")
  /// loco:68d4f8d82bc1b93265068752
  internal static let buttonModifyPassword = Localizable.tr("Localizable", "buttonModifyPassword", fallback: "Modify password")
  /// loco:68da784d25d05d451b04f663
  internal static let twoFactorAuthAlreadyValidatedErrorTitle = Localizable.tr("Localizable", "twoFactorAuthAlreadyValidatedErrorTitle", fallback: "This connection has already been validated from another device")
  /// loco:68da78cbe3aba64d960ff0c2
  internal static let twoFactorAuthCheckOriginDescription = Localizable.tr("Localizable", "twoFactorAuthCheckOriginDescription", fallback: "You didn’t initiate this validation? Check the activity of your last used devices.")
  /// loco:68c04f14ec33731be0018cb8
  internal static let twoFactorAuthConfirmationDescription = Localizable.tr("Localizable", "twoFactorAuthConfirmationDescription", fallback: "Confirming this login attempt will allow that device to access your Infomaniak account")
  /// loco:68d525efa14e70cfc4037845
  internal static let twoFactorAuthConnectionAlreadyValidatedTitle = Localizable.tr("Localizable", "twoFactorAuthConnectionAlreadyValidatedTitle", fallback: "This connection has already been validated from another device")
  /// loco:68d525a2a14e70cfc4037842
  internal static let twoFactorAuthConnectionExpiredTitle = Localizable.tr("Localizable", "twoFactorAuthConnectionExpiredTitle", fallback: "This connection request has expired")
  /// loco:68d5248990faa534e505f204
  internal static let twoFactorAuthConnectionRefusedDescription = Localizable.tr("Localizable", "twoFactorAuthConnectionRefusedDescription", fallback: "You have refused a login attempt. To secure your account, change your password. If you are the source of this attempt, try logging in again.")
  /// loco:68d5247e90faa534e505f202
  internal static let twoFactorAuthConnectionRefusedTitle = Localizable.tr("Localizable", "twoFactorAuthConnectionRefusedTitle", fallback: "Connection Refused")
  /// loco:68d525cbd0a3850b780837f2
  internal static let twoFactorAuthConnectionValidationDescription = Localizable.tr("Localizable", "twoFactorAuthConnectionValidationDescription", fallback: "You didn’t initiate this validation? Check the activity of your last used devices.")
  /// loco:68c04d95fa5d09365f02c055
  internal static let twoFactorAuthDeviceLabel = Localizable.tr("Localizable", "twoFactorAuthDeviceLabel", fallback: "Device")
  /// loco:68da77e9a0c5c4a1d809d4c4
  internal static let twoFactorAuthExpiredErrorTitle = Localizable.tr("Localizable", "twoFactorAuthExpiredErrorTitle", fallback: "This connection request has expired")
  /// loco:68de2abbe02b752bd80f2782
  internal static let twoFactorAuthGenericErrorDescription = Localizable.tr("Localizable", "twoFactorAuthGenericErrorDescription", fallback: "Unable to complete the operation.\nPlease try again.")
  /// loco:68c04e0aec33731be0018cb4
  internal static let twoFactorAuthLocationLabel = Localizable.tr("Localizable", "twoFactorAuthLocationLabel", fallback: "Location")
  /// Plural format key: "%#@value@"
  internal static func twoFactorAuthMinutesAgoLabel(_ p1: Int) -> String {
    return Localizable.tr("Localizable", "twoFactorAuthMinutesAgoLabel", p1, fallback: "Plural format key: \"%#@value@\"")
  }
  /// loco:68de26e7e0ead3ef030b71f2
  internal static let twoFactorAuthNoNetworkErrorDescription = Localizable.tr("Localizable", "twoFactorAuthNoNetworkErrorDescription", fallback: "Unable to complete the operation.\nCheck your connection and try again.")
  /// loco:68de2516c411b0f8b20a4832
  internal static let twoFactorAuthNoNetworkErrorTitle = Localizable.tr("Localizable", "twoFactorAuthNoNetworkErrorTitle", fallback: "No network connection")
  /// loco:68c053c71ea34fd57a062325
  internal static let twoFactorAuthTryingToLogInTitle = Localizable.tr("Localizable", "twoFactorAuthTryingToLogInTitle", fallback: "Are you trying to login?")
  /// loco:68c04d446368e16b82076535
  internal static let twoFactorAuthWhenLabel = Localizable.tr("Localizable", "twoFactorAuthWhenLabel", fallback: "When")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Localizable {
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
