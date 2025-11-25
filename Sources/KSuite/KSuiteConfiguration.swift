/*
 Infomaniak Features - iOS
 Copyright (C) 2025 Infomaniak Network SA

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import Foundation
import KSuiteUtils

public enum KSuiteConfiguration {
    case standard
    case business
    case enterprise

    var title: String {
        switch self {
        case .standard:
            KSuiteLocalizable.kSuiteStandardOfferTitle
        case .business:
            KSuiteLocalizable.kSuiteBusinessOfferTitle
        case .enterprise:
            KSuiteLocalizable.kSuiteEnterpriseOfferTitle
        }
    }

    var description: String {
        switch self {
        case .standard:
            KSuiteLocalizable.kSuiteStandardOfferDescription
        case .business:
            KSuiteLocalizable.kSuiteBusinessOfferDescription
        case .enterprise:
            KSuiteLocalizable.kSuiteEnterpriseOfferDescription
        }
    }

    private var storage: Int64 {
        switch self {
        case .standard:
            50_000_000_000
        case .business:
            3_000_000_000_000
        case .enterprise:
            6_000_000_000_000
        }
    }

    var labels: [KSuiteUtils.KSuiteLabel] {
        let byteFormatter = ByteCountFormatter()
        byteFormatter.allowedUnits = [.useGB, .useTB]
        let byteCount = "**\(byteFormatter.string(fromByteCount: storage))**"

        switch self {
        case .standard:
            return [
                KSuiteLabel(
                    icon: KSuiteResources.drive.swiftUIImage,
                    text: KSuiteLocalizable.kSuiteStorageLabel(byteCount)
                ),
                KSuiteLabel(
                    icon: KSuiteResources.kchat.swiftUIImage,
                    text: bold(string: KSuiteLocalizable.kSuiteStandardKChatLabel)
                ),
                KSuiteLabel(
                    icon: KSuiteResources.envelope.swiftUIImage,
                    text: bold(string: KSuiteLocalizable.kSuiteStandardMailLabel)
                ),
                KSuiteLabel(
                    icon: KSuiteResources.euria.swiftUIImage,
                    text: bold(string: KSuiteLocalizable.kSuiteStandardEuriaLabel)
                ),
                KSuiteLabel(
                    icon: KSuiteResources.plusCircle.swiftUIImage,
                    text: KSuiteLocalizable.kSuiteMoreLabel
                )
            ]
        case .business:
            return [
                KSuiteLabel(
                    icon: KSuiteResources.drive.swiftUIImage,
                    text: KSuiteLocalizable.kSuiteStorageLabel(byteCount)
                ),
                KSuiteLabel(
                    icon: KSuiteResources.kchat.swiftUIImage,
                    text: bold(string: KSuiteLocalizable.kSuiteBusinessKChatLabel)
                ),
                KSuiteLabel(
                    icon: KSuiteResources.folder.swiftUIImage,
                    text: bold(string: KSuiteLocalizable.kSuiteBusinessKDriveLabel)
                ),
                KSuiteLabel(
                    icon: KSuiteResources.shieldLock.swiftUIImage,
                    text: bold(string: KSuiteLocalizable.kSuiteBusinessSecurityLabel)
                ),
                KSuiteLabel(
                    icon: KSuiteResources.microsoft.swiftUIImage,
                    text: bold(string: KSuiteLocalizable.kSuiteBusinessMicrosoftLabel)
                ),
                KSuiteLabel(
                    icon: KSuiteResources.plusCircle.swiftUIImage,
                    text: KSuiteLocalizable.kSuiteMoreLabel
                )
            ]
        case .enterprise:
            return [
                KSuiteLabel(
                    icon: KSuiteResources.drive.swiftUIImage,
                    text: KSuiteLocalizable.kSuiteStorageLabel(byteCount)
                ),
                KSuiteLabel(
                    icon: KSuiteResources.kchat.swiftUIImage,
                    text: bold(string: KSuiteLocalizable.kSuiteEnterpriseKChatLabel)
                ),
                KSuiteLabel(
                    icon: KSuiteResources.folder.swiftUIImage,
                    text: bold(string: KSuiteLocalizable.kSuiteEnterpriseKDriveLabel)
                ),
                KSuiteLabel(
                    icon: KSuiteResources.stair.swiftUIImage,
                    text: bold(string: KSuiteLocalizable.kSuiteEnterpriseFunctionalityLabel)
                ),
                KSuiteLabel(
                    icon: KSuiteResources.plusCircle.swiftUIImage,
                    text: KSuiteLocalizable.kSuiteMoreLabel
                )
            ]
        }
    }

    private func bold(string: String) -> String {
        if let index = string.firstIndex(of: ":") {
            let newIndex = string.index(index, offsetBy: 1)
            let prefix = String(string.prefix(upTo: newIndex))
            let suffix = String(string.suffix(from: newIndex))
            return "**\(prefix)**\(suffix)"
        }
        if string.contains("Microsoft Office Online") {
            return string.replacingOccurrences(of: "Microsoft Office Online", with: "**Microsoft Office Online**")
        }
        return string
    }
}
