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
import KSuiteUtils
import SwiftUI

struct SubscriptionProductsView: View {
    let myKSuite: MyKSuite

    var body: some View {
        VStack(spacing: IKPadding.medium) {
            if myKSuite.isFree {
                ProductProgressView(
                    product: .mail,
                    usedValue: myKSuite.mail.usedSize,
                    totalValue: myKSuite.mail.storageSizeLimit
                )
            } else {
                HStack {
                    Text(Product.mail.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(ColorHelper.primary)
                        .font(FontHelper.body)

                    Text(MyKSuiteLocalizable.myKSuiteDashboardDataUnlimited)
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
