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

struct SubscriptionBenefitsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: IKPadding.large) {
            Text("myKSuiteUpgradeBenefitsTitle", bundle: .module)
                .foregroundStyle(ColorHelper.secondary)
                .font(FontHelper.bodySmall)

            Label {
                Text("myKSuiteUpgradeDriveLabel", bundle: .module)
            } icon: {
                Image("drive", bundle: .module)
                    .resizable()
                    .frame(width: 16, height: 16)
            }

            Label {
                Text("myKSuiteUpgradeUnlimitedMailLabel", bundle: .module)
            } icon: {
                Image("plane", bundle: .module)
                    .resizable()
                    .frame(width: 16, height: 16)
            }

            Label {
                Text("myKSuiteUpgradeLabel", bundle: .module)
            } icon: {
                Image("gift", bundle: .module)
                    .resizable()
                    .frame(width: 16, height: 16)
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
