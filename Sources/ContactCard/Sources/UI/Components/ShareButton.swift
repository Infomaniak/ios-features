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
import InfomaniakCoreSwiftUI
import Nuke
import NukeUI
import SwiftUI

private struct VCardTransferable: Transferable {
    let contactCard: ContactCard

    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(exportedContentType: .vCard) { item in
            let photoData = await item.cachedAvatarData()
            return await Data(item.contactCard.makeVCardString(photoData: photoData).utf8)
        }
    }

    private func cachedAvatarData() async -> PlatformImage? {
        guard let urlString = contactCard.avatarURL,
              let url = URL(string: urlString) else { return nil }
        return try? await ImagePipeline.shared.image(for: url)
    }
}

struct ShareButton: View {
    @Environment(\.contactCardTheme) private var contactCardTheme

    let contactCard: ContactCard

    var body: some View {
        ShareLink(
            item: VCardTransferable(contactCard: contactCard),
            preview: SharePreview(
                "\(contactCard.firstName) \(contactCard.lastName)"
            )
        ) {
            Text(Localizable.sharedButton)
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
    }
}
