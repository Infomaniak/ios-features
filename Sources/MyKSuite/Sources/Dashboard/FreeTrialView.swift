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

struct FreeTrialView: View {
    private let skyBackground = Color(
        light: MyKSuiteResources.Colors.sky.swiftUIColor,
        dark: MyKSuiteResources.Colors.bat.swiftUIColor
    )
    private let chipColor = Color(light: .white, dark: MyKSuiteResources.Colors.orca.swiftUIColor)

    var body: some View {
        VStack(alignment: .leading, spacing: IKPadding.medium) {
            HStack {
                MyKSuiteResources.Assets.myKSuitePlusLogo.swiftUIImage
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
