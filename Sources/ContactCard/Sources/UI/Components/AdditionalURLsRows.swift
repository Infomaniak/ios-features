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

    @Binding var additionalURLs: [String]

    var body: some View {
        ForEach(additionalURLs.indices, id: \.self) { index in
            HStack {
                // Create a binding to the specific element in the array
                let binding = Binding<String>(
                    get: { additionalURLs[index] },
                    set: { additionalURLs[index] = $0 }
                )

                TextField(Localizable.otherUrl, text: binding)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.URL)
                Button {
                    withAnimation {
                        additionalURLs.remove(at: index)
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
