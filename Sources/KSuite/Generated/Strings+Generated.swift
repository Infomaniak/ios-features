// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum KSuiteLocalizable {
  /// loco:689321dbe19fe82cd7087412
  internal static let kSuiteUpgradeDetailsContactAdmin = KSuiteLocalizable.tr("Localizable", " kSuiteUpgradeDetailsContactAdmin", fallback: "Contact your administrator to upgrade your offer.")
  /// loco:688b74f0e9091ea68006a122
  internal static let kSuiteBusinessKChatLabel = KSuiteLocalizable.tr("Localizable", "kSuiteBusinessKChatLabel", fallback: "kChat: shared channels, unlimited integration with other applications")
  /// loco:688b751e7a16f4c4af056e83
  internal static let kSuiteBusinessKDriveLabel = KSuiteLocalizable.tr("Localizable", "kSuiteBusinessKDriveLabel", fallback: "kDrive: content search, extended version history")
  /// loco:688b6cbb8ac935ed130e3705
  internal static let kSuiteBusinessOfferDescription = KSuiteLocalizable.tr("Localizable", "kSuiteBusinessOfferDescription", fallback: "Optimize your exchanges and structure collaboration throughout your organization.")
  /// loco:688b6c6b70085c4be6071a92
  internal static let kSuiteBusinessOfferTitle = KSuiteLocalizable.tr("Localizable", "kSuiteBusinessOfferTitle", fallback: "Gain impact and control with the business offer")
  /// loco:688b754fc9d22f4a32076322
  internal static let kSuiteBusinessSecurityLabel = KSuiteLocalizable.tr("Localizable", "kSuiteBusinessSecurityLabel", fallback: "Security: SSO login, PC backup, etc.")
  /// loco:688b75ae838dac7b2a000af2
  internal static let kSuiteEnterpriseFunctionalityLabel = KSuiteLocalizable.tr("Localizable", "kSuiteEnterpriseFunctionalityLabel", fallback: "Advanced features: Premium Support, Custom Brand, etc.")
  /// loco:688b756a5ca0bb203300e474
  internal static let kSuiteEnterpriseKChatLabel = KSuiteLocalizable.tr("Localizable", "kSuiteEnterpriseKChatLabel", fallback: "kChat: 200 external users, up to 1000 public/private channels")
  /// loco:688b75c7b687ddc15d066a62
  internal static let kSuiteEnterpriseMicrosoftLabel = KSuiteLocalizable.tr("Localizable", "kSuiteEnterpriseMicrosoftLabel", fallback: "Microsoft Office Online integration")
  /// loco:688b6cde60be19d6ba01e729
  internal static let kSuiteEnterpriseOfferDescription = KSuiteLocalizable.tr("Localizable", "kSuiteEnterpriseOfferDescription", fallback: "A secure collaboration environment for even the most demanding teams.")
  /// loco:688b6c8768c1a651fc07c764
  internal static let kSuiteEnterpriseOfferTitle = KSuiteLocalizable.tr("Localizable", "kSuiteEnterpriseOfferTitle", fallback: "Secure, centralize, control with the Enterprise offer")
  /// loco:68949e85cf319fb7c803f312
  internal static let kSuiteGetProDescription = KSuiteLocalizable.tr("Localizable", "kSuiteGetProDescription", fallback: "Create and collaborate without limits")
  /// loco:68949e54810c56a6160a31b4
  internal static let kSuiteGetProTitle = KSuiteLocalizable.tr("Localizable", "kSuiteGetProTitle", fallback: "Get kSuite")
  /// loco:688b74ceafa0be317a0bef62
  internal static let kSuiteMoreLabel = KSuiteLocalizable.tr("Localizable", "kSuiteMoreLabel", fallback: "And much, much more!")
  /// loco:688b74b977353df30e0cd682
  internal static let kSuiteStandardEuriaLabel = KSuiteLocalizable.tr("Localizable", "kSuiteStandardEuriaLabel", fallback: "Euria: video transcription, image creation, etc.")
  /// loco:688b7484149384c94b09fc12
  internal static let kSuiteStandardKChatLabel = KSuiteLocalizable.tr("Localizable", "kSuiteStandardKChatLabel", fallback: "kChat: unlimited message history, more channels, etc.")
  /// loco:688b74a0121272a5e3036d02
  internal static let kSuiteStandardMailLabel = KSuiteLocalizable.tr("Localizable", "kSuiteStandardMailLabel", fallback: "Mail: unlimited mail storage, scheduled mailings, etc.")
  /// loco:688b6ca1bfc9faabc80f7aa4
  internal static let kSuiteStandardOfferDescription = KSuiteLocalizable.tr("Localizable", "kSuiteStandardOfferDescription", fallback: "Give your team the essential tools to collaborate effectively on a daily basis.")
  /// loco:688b6c5368c1a651fc07c763
  internal static let kSuiteStandardOfferTitle = KSuiteLocalizable.tr("Localizable", "kSuiteStandardOfferTitle", fallback: "Step up a gear with the standard offer")
  /// loco:688b7452e7d2ef7c92095802
  internal static func kSuiteStorageLabel(_ p1: Any) -> String {
    return KSuiteLocalizable.tr("Localizable", "kSuiteStorageLabel", String(describing: p1), fallback: "%@ per kDrive and kChat cloud storage user")
  }
  /// loco:68949e21e9102e1eb00a6d04
  internal static let kSuiteUpgradeButton = KSuiteLocalizable.tr("Localizable", "kSuiteUpgradeButton", fallback: "EVOLVE")
  /// loco:688b6c0168c1a651fc07c762
  internal static let kSuiteUpgradeDetails = KSuiteLocalizable.tr("Localizable", "kSuiteUpgradeDetails", fallback: "To upgrade your offer, use the web interface.")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension KSuiteLocalizable {
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
