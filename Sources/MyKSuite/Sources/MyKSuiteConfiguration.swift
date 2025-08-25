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
import SwiftUI

public enum MyKSuiteConfiguration {
    case mail
    case kDrive

    var labels: [KSuiteUtils.KSuiteLabel] {
        switch self {
        case .mail:
            [
                KSuiteLabel(
                    icon: MyKSuiteResources.plane.swiftUIImage,
                    text: MyKSuiteLocalizable.myKSuiteUpgradeUnlimitedMailLabel
                ),
                KSuiteLabel(
                    icon: MyKSuiteResources.envelope.swiftUIImage,
                    text: MyKSuiteLocalizable.myKSuiteUpgradeRedirectLabel
                ),
                KSuiteLabel(
                    icon: MyKSuiteResources.gift.swiftUIImage,
                    text: MyKSuiteLocalizable.myKSuiteUpgradeLabel
                )
            ]
        case .kDrive:
            [
                KSuiteLabel(
                    icon: MyKSuiteResources.drive.swiftUIImage,
                    text: MyKSuiteLocalizable.myKSuiteUpgradeDriveLabel
                ),
                KSuiteLabel(
                    icon: MyKSuiteResources.folderArrowUp.swiftUIImage,
                    text: MyKSuiteLocalizable.myKSuiteUpgradePdfEditionLabel
                ),
                KSuiteLabel(
                    icon: MyKSuiteResources.gift.swiftUIImage,
                    text: MyKSuiteLocalizable.myKSuiteUpgradeLabel
                )
            ]
        }
    }
}
