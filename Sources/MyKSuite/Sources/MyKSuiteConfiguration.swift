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

import SwiftUI

public enum MyKSuiteConfiguration {
    case mail
    case kDrive

    var labels: [MyKSuiteLabel] {
        switch self {
        case .mail:
            [
                MyKSuiteLabel(
                    icon: ImageHelper.plane,
                    text: MyKSuiteLocalizable.myKSuiteUpgradeUnlimitedMailLabel
                ),
                MyKSuiteLabel(
                    icon: ImageHelper.envelope,
                    text: MyKSuiteLocalizable.myKSuiteUpgradeRedirectLabel
                ),
                MyKSuiteLabel(
                    icon: ImageHelper.gift,
                    text: MyKSuiteLocalizable.myKSuiteUpgradeLabel
                )
            ]
        case .kDrive:
            [
                MyKSuiteLabel(
                    icon: ImageHelper.drive,
                    text: MyKSuiteLocalizable.myKSuiteUpgradeDriveLabel
                ),
                MyKSuiteLabel(
                    icon: ImageHelper.folderArrowUp,
                    text: MyKSuiteLocalizable.myKSuiteUpgradePdfEditionLabel
                ),
                MyKSuiteLabel(
                    icon: ImageHelper.gift,
                    text: MyKSuiteLocalizable.myKSuiteUpgradeLabel
                )
            ]
        }
    }
}

struct MyKSuiteLabel: Identifiable {
    let id: String

    let icon: Image
    let text: String

    init(icon: Image, text: String) {
        self.icon = icon
        self.text = text
        id = text
    }
}
