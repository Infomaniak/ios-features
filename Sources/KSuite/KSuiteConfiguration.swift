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
