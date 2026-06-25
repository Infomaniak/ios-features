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
import PhotosUI
import SwiftUI

struct ContactCardAvatarPickerView: View {
    @Environment(\.contactCardTheme) private var contactCardTheme

    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?

    let userProfile: UserProfile

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            PhotosPicker(selection: $avatarItem, matching: .images, photoLibrary: .shared()) {
                if avatarImage != nil {
                    avatarImage?
                        .resizable()
                        .clipShape(.circle)
                        .scaledToFill()
                        .frame(width: 115, height: 115)
                } else {
                    Group {
                        if let rawAvatarURL = userProfile.avatar,
                           let avatarURL = URL(string: rawAvatarURL) {
                            AsyncImage(url: avatarURL) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 115, height: 115)
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
                            .stroke(Color(UIColor.gray))
                    )
                }
            }

            Image(systemName: "camera")
                .colorInvert()
                .padding(IKPadding.small)
                .background(.black, in: .circle)
                .overlay {
                    Circle().stroke(Color(UIColor.systemGray6), lineWidth: 5)
                }
                .offset(x: IKPadding.micro, y: IKPadding.micro)
        }
        .task(id: avatarItem) {
            if let loaded = try? await avatarItem?.loadTransferable(type: Image.self) {
                avatarImage = loaded
            }
        }
    }

    private var initialsView: some View {
        InitialsView(
            initials: NameFormatter(fullName: userProfile.displayName).initials,
            backgroundColor: Color.backgroundColor(from: userProfile.email.hash),
            foregroundColor: contactCardTheme.secondary,
            size: 115
        )
    }
}

#Preview {
    ContactCardAvatarPickerView(userProfile: ProfilFake.fakeUserProfile)
}
