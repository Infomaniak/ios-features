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

import DesignSystem
import InfomaniakCoreSwiftUI
import KSuiteUtils
import SwiftUI

public struct KSuiteView: View {
    @Environment(\.dismiss) private var dismiss

    private let configuration: KSuiteConfiguration
    private let isAdmin: Bool

    public init(configuration: KSuiteConfiguration, isAdmin: Bool) {
        self.configuration = configuration
        self.isAdmin = isAdmin
    }

    public var body: some View {
        UpSalePanelView(
            headerImage: KSuiteResources.background.swiftUIImage,
            title: configuration.title,
            description: configuration.description,
            labels: configuration.labels,
            additionalText: isAdmin ?
                KSuiteLocalizable.kSuiteUpgradeDetails : KSuiteLocalizable.kSuiteUpgradeDetailsContactAdmin
        )
    }
}

#Preview("Standard") {
    KSuiteView(configuration: .standard, isAdmin: false)
}

#Preview("Business") {
    KSuiteView(configuration: .business, isAdmin: false)
}

#Preview("Entreprise") {
    KSuiteView(configuration: .enterprise, isAdmin: false)
}
