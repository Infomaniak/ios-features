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

import SwiftUI

struct SubscriptionPlusDetailsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Text("myKSuiteDashboardTrialPeriod", bundle: .module)
                    .foregroundStyle(ColorHelper.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(
                    String(
                        format: NSLocalizedString("myKSuiteDashboardUntil", bundle: .module, comment: ""),
                        arguments: ["xx/xx/xxxx"]
                    )
                )
                .foregroundStyle(ColorHelper.secondary)
            }

            // Waiting for InAppPurchase

//            HStack {
//                Text("myKSuiteDashboardPaymentMethod", bundle: .module)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .foregroundStyle(ColorHelper.primary)
//                Text("!Apple Pay")
//                    .foregroundStyle(ColorHelper.secondary)
//            }

            HStack(alignment: .top, spacing: 12) {
                ImageHelper.information
                    .foregroundStyle(ColorHelper.secondary)

                VStack(alignment: .leading, spacing: 16) {
                    Text("myKSuiteManageSubscriptionDescription", bundle: .module)
                        .foregroundStyle(ColorHelper.primary)

                    Button {
                        // Gerer mon abonnement
                    } label: {
                        Text("myKSuiteManageSubscriptionButton", bundle: .module)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(value: .medium)
            .background(ColorHelper.backgroundSecondary, in: .rect(cornerRadius: 8))
        }
    }
}

#Preview {
    SubscriptionPlusDetailsView()
}
