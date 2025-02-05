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

struct SubscriptionCardView: View {
    let myKSuite: MyKSuite

    var body: some View {
        VStack(spacing: 24) {
            HeaderView(myKSuite: myKSuite)

            Divider()

            SubscriptionProductsView(myKSuite: myKSuite)

            Divider()

            if myKSuite.isFree {
                SubscriptionFreeDetailsView(dailyLimit: myKSuite.freeMail.dailyLimitSent)
            } else {
                SubscriptionPlusDetailsView()
            }
        }
        .padding(value: .medium)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(ColorHelper.backgroundPrimary)
        .cardStyle()
    }
}

#Preview {
    SubscriptionCardView(myKSuite: PreviewHelper.sampleMyKSuite)
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .background {
            ImageHelper.background
                .resizable()
                .scaledToFit()
                .frame(maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea()
        }
}
