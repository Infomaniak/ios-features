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
import SwiftUI

struct RowView<Content: View>: View {
    let title: String
    @ViewBuilder let description: Content

    var body: some View {
        VStack(alignment: .leading, spacing: IKPadding.micro) {
            Text(title)
                .font(.Custom.callout)
                .foregroundStyle(Color.Custom.textSecondary)
            description
                .font(.Custom.headline)
                .foregroundStyle(Color.Custom.textPrimary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension RowView where Content == Text {
    init(title: String, description: String) {
        self.title = title
        self.description = Text(description)
    }
}

#Preview {
    VStack {
        RowView(title: "Device") {
            HStack {
                Text("iPhone 17")
                Image(systemName: "iphone.gen2")
            }
        }
        RowView(title: "Place", description: "Switzerland")
    }
}
