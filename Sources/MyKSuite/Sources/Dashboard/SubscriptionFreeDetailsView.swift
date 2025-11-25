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

struct SubscriptionFreeDetailsView: View {
    let dailyLimit: Int

    var body: some View {
        VStack(alignment: .leading, spacing: IKPadding.mini) {
            Label {
                Text(MyKSuiteLocalizable.myKSuiteDashboardFreeMailLabel)
            } icon: {
                Image(systemName: "envelope")
                    .iconSize(.medium)
                    .foregroundStyle(ColorHelper.secondary)
            }
            .padding(.vertical, value: .mini)

            DisclosureGroup {
                VStack(alignment: .leading, spacing: IKPadding.mini) {
                    Text(MyKSuiteLocalizable.myKSuiteDashboardFunctionalityMailAndDrive)
                    HStack {
                        Text(MyKSuiteLocalizable.myKSuiteDashboardFunctionalityLimit)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("\(dailyLimit)")
                            .foregroundStyle(ColorHelper.primary)
                            .font(FontHelper.bodySmallMedium)
                    }
                    Text(MyKSuiteLocalizable.myKSuiteDashboardFunctionalityCustomReminders)
                }
                .padding(.top, value: .mini)
                .foregroundStyle(ColorHelper.secondary)
                .font(FontHelper.bodySmall)
            } label: {
                Label {
                    Text(MyKSuiteLocalizable.myKSuiteDashboardLimitedFunctionalityLabel)
                } icon: {
                    MyKSuiteResources.lock.swiftUIImage
                        .iconSize(.medium)
                        .foregroundStyle(ColorHelper.secondary)
                }
                .padding(.vertical, value: .mini)
            }
            .tint(ColorHelper.secondary)
        }
        .font(FontHelper.body)
        .foregroundStyle(ColorHelper.primary)
    }
}

#Preview {
    SubscriptionFreeDetailsView(dailyLimit: 500)
}
