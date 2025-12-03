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

import InfomaniakCore
import InfomaniakCoreSwiftUI
import Nuke
import NukeUI
import SwiftUI

struct ConnectedAccountAvatarView: View {
    let connectedAccount: ConnectedAccount
    var size: CGFloat = 40

    var body: some View {
        Group {
            if let rawAvatarURL = connectedAccount.userProfile.avatar,
               let avatarURL = URL(string: rawAvatarURL) {
                LazyImage(request: ImageRequest(url: avatarURL)) { state in
                    if let image = state.image {
                        AvatarImage(image: image, size: size)
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
                .stroke(Color.greyMouse)
        )
    }

    private var initialsView: some View {
        InitialsView(
            initials: NameFormatter(fullName: connectedAccount.userProfile.displayName).initials,
            backgroundColor: Color.backgroundColor(from: connectedAccount.userProfile.email.hash),
            foregroundColor: Color.backgroundSecondary,
            size: size
        )
    }
}

#Preview {
    VStack {
        ConnectedAccountAvatarView(connectedAccount: PreviewHelper.connectedAccount)
        ConnectedAccountAvatarView(connectedAccount: PreviewHelper.connectedAccount2)
    }
}
