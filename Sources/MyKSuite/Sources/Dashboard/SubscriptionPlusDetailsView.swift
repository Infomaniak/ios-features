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

struct SubscriptionPlusDetailsView: View {
    let myKSuite: MyKSuite

    private let managerURL = URL(string: "https://manager.infomaniak.com/v3/ng/home")

    var body: some View {
        VStack(alignment: .leading, spacing: IKPadding.large) {
            if let trialDate = myKSuite.formattedTrialExpiryDate {
                HStack {
                    Text(MyKSuiteLocalizable.myKSuiteDashboardTrialPeriod)
                        .foregroundStyle(ColorHelper.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text(MyKSuiteLocalizable.myKSuiteDashboardUntil(trialDate))
                        .foregroundStyle(ColorHelper.secondary)
                }
            }

            HStack(alignment: .iconAndMultilineTextAlignment, spacing: IKPadding.small) {
                MyKSuiteResources.information.swiftUIImage
                    .iconSize(.medium)
                    .foregroundStyle(ColorHelper.secondary)
                    .alignmentGuide(.iconAndMultilineTextAlignment) { d in
                        d[VerticalAlignment.center]
                    }

                VStack(alignment: .leading, spacing: IKPadding.medium) {
                    Text(MyKSuiteLocalizable.myKSuiteManageSubscriptionDescription)
                        .foregroundStyle(ColorHelper.primary)
                        .alignmentGuide(.iconAndMultilineTextAlignment) { d in
                            (d.height - (d[.lastTextBaseline] - d[.firstTextBaseline])) / 2
                        }

                    if let managerURL {
                        Link(destination: managerURL) {
                            Text(MyKSuiteLocalizable.myKSuiteManageSubscriptionButton)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(value: .medium)
            .background(ColorHelper.backgroundSecondary, in: .rect(cornerRadius: IKRadius.medium))
        }
    }
}

#Preview {
    SubscriptionPlusDetailsView(myKSuite: PreviewHelper.sampleMyKSuite)
}
