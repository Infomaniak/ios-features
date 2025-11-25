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
