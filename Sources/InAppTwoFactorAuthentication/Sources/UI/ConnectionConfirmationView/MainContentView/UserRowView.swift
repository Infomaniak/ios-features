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
