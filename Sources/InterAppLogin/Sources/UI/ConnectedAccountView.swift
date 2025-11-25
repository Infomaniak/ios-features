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
