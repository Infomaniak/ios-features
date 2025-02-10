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
                    Resources.Assets.lock.swiftUIImage
                        .iconSize(.medium)
                        .foregroundStyle(ColorHelper.secondary)
                }
                .padding(.vertical, value: .mini)
            }
        }
        .font(FontHelper.body)
        .foregroundStyle(ColorHelper.primary)
    }
}

#Preview {
    SubscriptionFreeDetailsView(dailyLimit: 500)
}
