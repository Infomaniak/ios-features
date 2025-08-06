/*
 iOS Features
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

    var labels: [KSuiteUtils.KSuiteLabel] {
        switch self {
        case .standard:
            [
                KSuiteLabel(
                    icon: KSuiteResources.drive.swiftUIImage,
                    text: KSuiteLocalizable.kSuiteStorageLabel("50 Go")
                ),
                KSuiteLabel(
                    icon: KSuiteResources.kchat.swiftUIImage,
                    text: KSuiteLocalizable.kSuiteStandardKChatLabel
                ),
                KSuiteLabel(
                    icon: KSuiteResources.envelope.swiftUIImage,
                    text: KSuiteLocalizable.kSuiteStandardMailLabel
                ),
                KSuiteLabel(
                    icon: KSuiteResources.euria.swiftUIImage,
                    text: KSuiteLocalizable.kSuiteStandardEuriaLabel
                ),
                KSuiteLabel(
                    icon: KSuiteResources.plusCircle.swiftUIImage,
                    text: KSuiteLocalizable.kSuiteMoreLabel
                )
            ]
        case .business:
            [
                KSuiteLabel(
                    icon: KSuiteResources.drive.swiftUIImage,
                    text: KSuiteLocalizable.kSuiteStorageLabel("3 To")
                ),
                KSuiteLabel(
                    icon: KSuiteResources.kchat.swiftUIImage,
                    text: KSuiteLocalizable.kSuiteBusinessKChatLabel
                ),
                KSuiteLabel(
                    icon: KSuiteResources.folder.swiftUIImage,
                    text: KSuiteLocalizable.kSuiteBusinessKDriveLabel
                ),
                KSuiteLabel(
                    icon: KSuiteResources.shieldLock.swiftUIImage,
                    text: KSuiteLocalizable.kSuiteBusinessSecurityLabel
                ),
                KSuiteLabel(
                    icon: KSuiteResources.plusCircle.swiftUIImage,
                    text: KSuiteLocalizable.kSuiteMoreLabel
                )
            ]
        case .enterprise:
            [
                KSuiteLabel(
                    icon: KSuiteResources.drive.swiftUIImage,
                    text: KSuiteLocalizable.kSuiteStorageLabel("6 To")
                ),
                KSuiteLabel(
                    icon: KSuiteResources.kchat.swiftUIImage,
                    text: KSuiteLocalizable.kSuiteEnterpriseKChatLabel
                ),
                KSuiteLabel(
                    icon: KSuiteResources.stair.swiftUIImage,
                    text: KSuiteLocalizable.kSuiteEnterpriseFunctionalityLabel
                ),
                KSuiteLabel(
                    icon: KSuiteResources.microsoft.swiftUIImage,
                    text: KSuiteLocalizable.kSuiteEnterpriseMicrosoftLabel
                ),
                KSuiteLabel(
                    icon: KSuiteResources.plusCircle.swiftUIImage,
                    text: KSuiteLocalizable.kSuiteMoreLabel
                )
            ]
        }
    }
}
