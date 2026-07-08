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

import Foundation
import SwiftUI

struct AdditionalURLsRows: View {
    @Environment(\.contactCardTheme) private var contactCardTheme

    @Binding var additionalURLs: [IdentifiableURL]

    var body: some View {
        ForEach($additionalURLs) { entry in
            HStack {
                TextField(Localizable.otherUrl, text: entry.value)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.URL)
                Button {
                    withAnimation {
                        additionalURLs.removeAll { $0.id == entry.id }
                    }
                } label: {
                    Image(.bin)
                        .foregroundStyle(contactCardTheme.primary)
                }
                .buttonStyle(.borderless)
            }
        }
    }
}
