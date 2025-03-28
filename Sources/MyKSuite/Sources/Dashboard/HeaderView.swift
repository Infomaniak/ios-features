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

struct HeaderView<Content: View>: View {
    let myKSuite: MyKSuite
    let avatarView: () -> Content

    var body: some View {
        HStack {
            ZStack {
                MyKSuiteResources.Assets.person.swiftUIImage
                    .iconSize(.medium)
                    .foregroundStyle(ColorHelper.secondary)

                avatarView()
                    .frame(width: 24, height: 24)
            }
            .frame(width: 24, height: 24)
            .overlay {
                Circle()
                    .strokeBorder(ColorHelper.gradient, lineWidth: 1)
            }
            .background(MyKSuiteResources.Colors.polarBear.swiftUIColor)
            .clipShape(.circle)

            Text(myKSuite.mail.email)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(ColorHelper.primary)
                .font(FontHelper.body)

            myKSuite.icon
                .padding(.horizontal, value: .mini)
                .padding(.vertical, value: .micro)
                .background(ColorHelper.reversedPrimary)
                .clipShape(Capsule())
        }
    }
}

#Preview {
    HeaderView(myKSuite: PreviewHelper.sampleMyKSuite) { EmptyView() }
}
