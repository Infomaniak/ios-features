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

struct SubscriptionBenefitsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: IKPadding.large) {
            Text(MyKSuiteLocalizable.myKSuiteUpgradeBenefitsTitle)
                .foregroundStyle(ColorHelper.secondary)
                .font(FontHelper.bodySmall)

            Label {
                Text(MyKSuiteLocalizable.myKSuiteUpgradeDriveLabel)
            } icon: {
                Image("drive", bundle: .module)
                    .iconSize(.medium)
            }

            Label {
                Text(MyKSuiteLocalizable.myKSuiteUpgradeUnlimitedMailLabel)
            } icon: {
                Image("plane", bundle: .module)
                    .iconSize(.medium)
            }

            Label {
                Text(MyKSuiteLocalizable.myKSuiteUpgradeLabel)
            } icon: {
                Image("gift", bundle: .module)
                    .iconSize(.medium)
            }
        }
        .foregroundStyle(ColorHelper.primary)
        .font(FontHelper.body)
        .padding(value: .medium)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(ColorHelper.backgroundPrimary)
        .cardStyle()
    }
}

#Preview {
    SubscriptionBenefitsView()
        .padding()
}
