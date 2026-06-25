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

struct UserProfileCell: View {
    @Environment(\.contactCardTheme) private var contactCardTheme

    let userProfile: UserProfile

    var body: some View {
        HStack(spacing: IKPadding.medium) {
            UserProfileAvatarView(userProfile: userProfile, size: 40)

            VStack(alignment: .leading, spacing: IKPadding.micro) {
                Text("\(userProfile.firstName) \(userProfile.lastName)")
                    .font(.Custom.title2)
                    .foregroundStyle(contactCardTheme.primaryText)

                Text("\(userProfile.email)")
                    .font(.Custom.body)
                    .foregroundStyle(contactCardTheme.secondaryText)
                    .lineLimit(0)
            }
            .frame(maxWidth: 225)
        }
    }
}

#Preview {
    UserProfileCell(userProfile: ProfileFake.fakeUserProfile)
}
