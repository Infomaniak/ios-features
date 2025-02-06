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
        VStack(alignment: .leading, spacing: IKPadding.large) {
            Label {
                Text("myKSuiteDashboardFreeMailLabel", bundle: .module)
            } icon: {
                Image(systemName: "envelope")
                    .iconSize(.medium)
                    .foregroundStyle(ColorHelper.secondary)
            }

            DisclosureGroup {
                VStack(alignment: .leading, spacing: 8) {
                    Text("myKSuiteDashboardFunctionalityMailAndDrive", bundle: .module)
                    HStack {
                        Text("myKSuiteDashboardFunctionalityLimit", bundle: .module)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("\(dailyLimit)")
                            .foregroundStyle(ColorHelper.primary)
                            .font(FontHelper.bodySmallMedium)
                    }
                    Text("myKSuiteDashboardFunctionalityCustomReminders", bundle: .module)
                }
                .padding(.top, 18)
                .foregroundStyle(ColorHelper.secondary)
                .font(FontHelper.bodySmall)
            } label: {
                Label {
                    Text("myKSuiteDashboardLimitedFunctionalityLabel", bundle: .module)
                } icon: {
                    ImageHelper.lock
                        .iconSize(.medium)
                        .foregroundStyle(ColorHelper.secondary)
                }
            }
        }
        .font(FontHelper.body)
        .foregroundStyle(ColorHelper.primary)
    }
}

#Preview {
    SubscriptionFreeDetailsView(dailyLimit: 500)
}
