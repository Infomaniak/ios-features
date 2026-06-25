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
import Foundation
import InfomaniakCore
import InfomaniakCoreSwiftUI
import SwiftUI

struct ContactCardQRCodeView: View {
    @Environment(\.contactCardTheme) private var contactCardTheme

    let userProfile: UserProfile

    var body: some View {
        VStack {
            Image(systemName: "qrcode")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .foregroundColor(contactCardTheme.primaryText)
                .padding(IKPadding.large)
                .background(contactCardTheme.onAccent, in: .rect(cornerRadius: IKRadius.large))
                .overlay(
                    QRFrameShape(cornerLength: 250 / 8)
                        .stroke(
                            contactCardTheme.primary,
                            style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round)
                        )
                )
                .padding(.bottom, IKPadding.huge)

            UserProfileCell(userProfile: userProfile)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, IKPadding.huge)
        .safeAreaInset(edge: .bottom, content: {
            Button {
                // Nothing for now (navigation will be added later)
            } label: {
                Label(MyString.qrCodeShared, systemImage: MyString.qrCodeSharedImage)
            }
            .buttonStyle(.ikBorderedProminent)
            .ikButtonFullWidth(true)
            .controlSize(.large)
            .ikButtonTheme(
                IKButtonTheme(
                    primary: contactCardTheme.primary,
                    secondary: contactCardTheme.secondary,
                    tertiary: Color.gray,
                    disabledPrimary: Color.gray,
                    disabledSecondary: Color.white,
                    error: Color.red,
                    smallFont: .body,
                    mediumFont: .headline
                )
            )
            .padding(.horizontal, IKPadding.large)
            .padding(.bottom, IKPadding.mini)
        })
        .background(contactCardTheme.background)
    }
}

#Preview {
    ContactCardQRCodeView(userProfile: ProfileFake.fakeUserProfile)
}
