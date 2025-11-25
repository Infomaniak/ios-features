/*
 Infomaniak Features - iOS
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
import KSuiteUtils
import SwiftUI

struct SubscriptionCardView<Content: View>: View {
    let myKSuite: MyKSuite
    let avatarView: () -> Content

    var body: some View {
        VStack(spacing: IKPadding.large) {
            HeaderView(myKSuite: myKSuite, avatarView: avatarView)

            Divider()
                .overlay(ColorHelper.divider)

            SubscriptionProductsView(myKSuite: myKSuite)

            Divider()
                .overlay(ColorHelper.divider)

            if myKSuite.isFree {
                SubscriptionFreeDetailsView(dailyLimit: myKSuite.mail.dailyLimitSent)
            } else {
                SubscriptionPlusDetailsView(myKSuite: myKSuite)
            }
        }
        .padding(value: .medium)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(ColorHelper.backgroundPrimary)
        .cardStyle()
    }
}

#Preview {
    SubscriptionCardView(myKSuite: PreviewHelper.sampleMyKSuite) {
        EmptyView()
    }
    .padding()
    .frame(maxHeight: .infinity, alignment: .top)
    .background {
        MyKSuiteResources.background.swiftUIImage
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity, alignment: .top)
            .ignoresSafeArea()
    }
}
