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
import SwiftUI

struct SubscriptionProductsView: View {
    let myKSuite: MyKSuite

    var body: some View {
        VStack(spacing: IKPadding.medium) {
            if myKSuite.isFree {
                ProductProgressView(
                    product: .mail,
                    usedValue: myKSuite.freeMail.usedSize,
                    totalValue: myKSuite.freeMail.storageSizeLimit
                )
            } else {
                HStack {
                    Text(Product.mail.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(ColorHelper.primary)
                        .font(FontHelper.body)

                    Text("myKSuiteDashboardDataUnlimited", bundle: .module)
                        .foregroundStyle(ColorHelper.secondary)
                        .font(FontHelper.bodySmall)
                }
            }

            ProductProgressView(product: .drive, usedValue: myKSuite.drive.usedSize, totalValue: myKSuite.drive.size)
        }
    }
}

#Preview {
    SubscriptionProductsView(myKSuite: PreviewHelper.sampleMyKSuite)
}
