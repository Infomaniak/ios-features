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

public struct MyKSuiteView: View {
    @Environment(\.dismiss) private var dismiss

    private let configuration: MyKSuiteConfiguration

    public init(configuration: MyKSuiteConfiguration) {
        self.configuration = configuration
    }

    public var body: some View {
        UpSalePanelView(
            headerImage: MyKSuiteResources.gradient.swiftUIImage,
            title: MyKSuiteLocalizable.myKSuiteUpgradeTitle,
            description: MyKSuiteLocalizable.myKSuiteUpgradeDescription,
            labels: configuration.labels,
            additionalText: MyKSuiteLocalizable.myKSuiteUpgradeDetails
        )
    }
}

#Preview("kDrive") {
    MyKSuiteView(configuration: .kDrive)
}

#Preview("Mail") {
    MyKSuiteView(configuration: .mail)
}
