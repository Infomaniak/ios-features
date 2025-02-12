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

import DesignSystem
import InfomaniakCoreSwiftUI
import SwiftUI

struct SubscriptionPlusDetailsView: View {
    let myKSuite: MyKSuite

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
                MyKSuiteResources.Assets.information.swiftUIImage
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

                    Button {
                        // Gerer mon abonnement
                    } label: {
                        Text(MyKSuiteLocalizable.myKSuiteManageSubscriptionButton)
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
