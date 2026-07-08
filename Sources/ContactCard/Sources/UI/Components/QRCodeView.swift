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
import SwiftUI

struct QRCodeView: View {
    @Environment(\.contactCardTheme) private var contactCardTheme

    let userProfile: UserProfile
    let contactCard: ContactCard

    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundStyle(contactCardTheme.primary)
                .frame(width: .infinity, height: 80)

            ContactCardQRCodeGeneratorView(userProfile: userProfile, contactCard: contactCard)
                .environment(\.contactCardTheme, contactCardTheme)
                .frame(width: 200, height: 200)
                .padding(IKPadding.large)
                .background(contactCardTheme.background, in: RoundedRectangle(cornerRadius: IKRadius.large))
                .shadow(radius: 4, x: 0, y: 2)
                .padding(.top, IKPadding.huge)
                .padding(.bottom, IKPadding.small)
        }
        .frame(maxWidth: .infinity)
    }
}
