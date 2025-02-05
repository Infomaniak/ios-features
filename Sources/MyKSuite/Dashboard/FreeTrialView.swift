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

struct FreeTrialView: View {
    private let skyBackground = Color(light: ColorHelper.sky, dark: ColorHelper.bat)
    private let chipColor = Color(light: .white, dark: ColorHelper.orca)

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                ImageHelper.myKSuitePlusLogo
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90)

                Spacer()

                Text("myKSuiteDashboardFreeTrialTitle", bundle: .module)
                    .font(FontHelper.labelMedium)
                    .foregroundStyle(ColorHelper.primary)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .background(chipColor, in: .capsule)
            }
            Text("myKSuiteDashboardFreeTrialDescription", bundle: .module)
                .font(FontHelper.bodySmall)
                .foregroundStyle(ColorHelper.primary)

            Button {
                // Start trial
            } label: {
                Text("myKSuiteDashboardFreeTrialButton", bundle: .module)
            }
            .controlSize(.large)
            .ikButtonFullWidth(true)
            .buttonStyle(.ikBorderedProminent)
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(ColorHelper.gradient, lineWidth: 1)
        }
        .background(skyBackground, in: .rect(cornerRadius: 16))
        .cardStyle(withStroke: false)
    }
}

#Preview {
    FreeTrialView()
}
