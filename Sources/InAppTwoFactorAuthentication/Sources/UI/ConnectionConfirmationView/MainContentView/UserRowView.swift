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
import InfomaniakCore
import InfomaniakCoreSwiftUI
import NukeUI
import SwiftUI

struct UserRowView: View {
    let user: InfomaniakUser
    let avatarSize: CGFloat = 40

    var body: some View {
        HStack(spacing: IKPadding.mini) {
            Group {
                if let rawAvatarURL = user.avatar,
                   let avatarURL = URL(string: rawAvatarURL) {
                    LazyImage(request: ImageRequest(url: avatarURL)) { state in
                        if let image = state.image {
                            AvatarImage(image: image, size: avatarSize)
                        } else {
                            initialsView
                        }
                    }
                } else {
                    initialsView
                }
            }
            .clipShape(Circle())
            .background(
                Circle()
                    .stroke(Color.gray)
            )

            VStack(alignment: .leading) {
                Text(user.displayName)
                    .font(.Custom.headline)
                    .foregroundStyle(Color.Custom.textPrimary)
                Text(user.email)
                    .font(.Custom.body)
                    .foregroundStyle(Color.Custom.textSecondary)
            }
        }
    }

    private var initialsView: some View {
        InitialsView(
            initials: NameFormatter(fullName: user.displayName).initials,
            backgroundColor: Color.backgroundColor(from: user.email.hash),
            foregroundColor: Color.white,
            size: avatarSize
        )
    }
}

#Preview {
    VStack(alignment: .leading) {
        UserRowView(user: PreviewUser.preview)
        UserRowView(user: PreviewUser.previewNoAvatar)
    }
}
