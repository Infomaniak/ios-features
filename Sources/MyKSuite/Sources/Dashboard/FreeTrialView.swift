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

struct FreeTrialView: View {
    private let skyBackground = Color(
        light: KSuiteUtilsResources.sky.color,
        dark: KSuiteUtilsResources.bat.color
    )
    private let chipColor = Color(light: .white, dark: KSuiteUtilsResources.orca.color)

    var body: some View {
        VStack(alignment: .leading, spacing: IKPadding.medium) {
            HStack {
                MyKSuiteResources.myKSuitePlusLogo.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 90)

                Spacer()

                Text(MyKSuiteLocalizable.myKSuiteDashboardFreeTrialTitle)
                    .font(FontHelper.labelMedium)
                    .foregroundStyle(ColorHelper.primary)
                    .padding(.vertical, 2)
                    .padding(.horizontal, value: .mini)
                    .background(chipColor, in: .capsule)
            }
            Text(MyKSuiteLocalizable.myKSuiteDashboardFreeTrialDescription)
                .font(FontHelper.bodySmall)
                .foregroundStyle(ColorHelper.primary)

            Button {
                // Start trial
            } label: {
                Text(MyKSuiteLocalizable.myKSuiteDashboardFreeTrialButton)
            }
            .controlSize(.large)
            .ikButtonFullWidth(true)
            .buttonStyle(.ikBorderedProminent)
        }
        .padding(value: .medium)
        .background {
            RoundedRectangle(cornerRadius: IKRadius.large)
                .strokeBorder(ColorHelper.gradient, lineWidth: 1)
        }
        .background(skyBackground, in: .rect(cornerRadius: IKRadius.large))
        .cardStyle(withStroke: false)
    }
}

#Preview {
    FreeTrialView()
}
