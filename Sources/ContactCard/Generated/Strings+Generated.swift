// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Localizable {
  /// loco:6a4b9b67bd16f080d90102e2
  internal static let addUrl = Localizable.tr("Localizable", "addUrl", fallback: "Add URL")
  /// loco:6a4b9d07bc130aadd700d437
  internal static let alertDescription = Localizable.tr("Localizable", "alertDescription", fallback: "Please fill in all required fields (first name, last name, email, phone number).")
  /// loco:6a4b9ce6d4245bfa0406af22
  internal static let alertTitle = Localizable.tr("Localizable", "alertTitle", fallback: "Required fields")
  /// loco:6a4b9c54d3716a1c8e0782f3
  internal static let buttonCreate = Localizable.tr("Localizable", "buttonCreate", fallback: "Create")
  /// loco:6a4bc7948b43c4c4c30df3d9
  internal static let buttonMore = Localizable.tr("Localizable", "buttonMore", fallback: "More")
  /// loco:6a4b9a9c774c94b68f0ee222
  internal static let company = Localizable.tr("Localizable", "company", fallback: "Company")
  /// loco:6a4b98882db06191c30a2d62
  internal static let contactCardOnBoardingDescription = Localizable.tr("Localizable", "contactCardOnBoardingDescription", fallback: "Have your QR code scanned with a single gesture. Your contacts can add you in the blink of an eye, with or without an internet connection.")
  /// loco:6a4b98dc61385ce8da05ce02
  internal static let contactCardOnBoardingFirstItem = Localizable.tr("Localizable", "contactCardOnBoardingFirstItem", fallback: "All your information in a QR code")
  /// loco:6a4b9913dcfe91b97c0b6b82
  internal static let contactCardOnBoardingSecondItem = Localizable.tr("Localizable", "contactCardOnBoardingSecondItem", fallback: "No account required on the recipient’s end")
  /// loco:6a4b999aa82d0a517109ceb3
  internal static let contactCardOnBoardingStart = Localizable.tr("Localizable", "contactCardOnBoardingStart", fallback: "Get Started")
  /// loco:6a4b993d0bd42849960af6f2
  internal static let contactCardOnBoardingThirdItem = Localizable.tr("Localizable", "contactCardOnBoardingThirdItem", fallback: "Always accessible, even offline")
  /// loco:6a4b981712adf2df780e5ea5
  internal static let contactCardOnBoardingTitle = Localizable.tr("Localizable", "contactCardOnBoardingTitle", fallback: "Create Your Business Card")
  /// loco:6a4b9cb1bc130aadd700d435
  internal static let contactCardTitle = Localizable.tr("Localizable", "contactCardTitle", fallback: "Contact Card")
  /// loco:6a4bc870019edb131005f5c2
  internal static let continueButton = Localizable.tr("Localizable", "continueButton", fallback: "Continue")
  /// loco:6a4b9e3f01d1baf89d0c4213
  internal static let deleteAlertDescription = Localizable.tr("Localizable", "deleteAlertDescription", fallback: "Are you sure you want to delete the contact card associated with this account?")
  /// loco:6a4b9e19ac8f970c1e0773d2
  internal static let deleteAlertTitle = Localizable.tr("Localizable", "deleteAlertTitle", fallback: "Delete the contact card")
  /// loco:6a4b9e65ac8f970c1e0773d4
  internal static let deleteButton = Localizable.tr("Localizable", "deleteButton", fallback: "Delete")
  /// loco:6a4b9a1af5a40c56ce0fdec2
  internal static let email = Localizable.tr("Localizable", "email", fallback: "Email")
  /// loco:6a4b9ae5962ed69f9e0406e2
  internal static let facebook = Localizable.tr("Localizable", "facebook", fallback: "Facebook")
  /// loco:6a4b99c21a71443d2e075653
  internal static let firstName = Localizable.tr("Localizable", "firstName", fallback: "First Name")
  /// loco:6a4b9bc63bfc66f09e0b1945
  internal static let generalInformation = Localizable.tr("Localizable", "generalInformation", fallback: "General information")
  /// loco:6a4b9af5c4532701980bca1b
  internal static let instagram = Localizable.tr("Localizable", "instagram", fallback: "Instagram")
  /// loco:6a4b99f1da8d075ab10d92f9
  internal static let lastName = Localizable.tr("Localizable", "lastName", fallback: "Last Name")
  /// loco:6a4b9ad13c1285ac5806e422
  internal static let linkedIn = Localizable.tr("Localizable", "linkedIn", fallback: "LinkedIn")
  /// loco:6a4b9bfb27a74b691f04e233
  internal static let linksAndSocialNetwork = Localizable.tr("Localizable", "linksAndSocialNetwork", fallback: "Links and social network")
  /// loco:6a4b9ddc111a71c69f0998f2
  internal static let menuEdit = Localizable.tr("Localizable", "menuEdit", fallback: "Edit")
  /// loco:6a4b9b4a774c94b68f0ee224
  internal static let otherUrl = Localizable.tr("Localizable", "otherUrl", fallback: "Other URL")
  /// loco:6a4b9a84c4532701980bca19
  internal static let phone = Localizable.tr("Localizable", "phone", fallback: "Phone")
  /// loco:6a4b9dbd983cc71bfb0a1c92
  internal static let qrCodeGenerationError = Localizable.tr("Localizable", "qrCodeGenerationError", fallback: "Unable to generate the QR code")
  /// loco:6a4b9d878cdc0d546a04a343
  internal static let sharedButton = Localizable.tr("Localizable", "sharedButton", fallback: "Share")
  /// loco:6a4b9b263bfc66f09e0b1942
  internal static let webSite = Localizable.tr("Localizable", "webSite", fallback: "Web site")
  /// loco:6a4b9b112d7064a7f1021fe2
  internal static let x = Localizable.tr("Localizable", "x", fallback: "X")
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
