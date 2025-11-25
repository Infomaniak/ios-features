//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.

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
