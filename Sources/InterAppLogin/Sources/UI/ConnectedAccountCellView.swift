/*
 iOS Features
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

struct ConnectedAccountCellView: View {
    let connectedAccount: ConnectedAccount
    @Binding var isSelected: Bool

    var body: some View {
        Button {
            isSelected.toggle()
        } label: {
            HStack {
                ConnectedAccountAvatarView(connectedAccount: connectedAccount)
                VStack(alignment: .leading, spacing: 0) {
                    Text(connectedAccount.userProfile.displayName)
                        .font(.Custom.headline)
                        .foregroundStyle(Color.Custom.textPrimary)
                    Text(connectedAccount.userProfile.email)
                        .font(.Custom.body)
                        .foregroundStyle(Color.Custom.textSecondary)
                }
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)

                Image(.check)
                    .iconSize(.medium)
                    .foregroundStyle(.tint)
                    .opacity(isSelected ? 1 : 0)
                    .animation(nil, value: isSelected)
            }
            .padding(.vertical, value: .mini)
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    @Previewable @State var isFirstSelected = true
    @Previewable @State var isSecondSelected = false
    VStack {
        ConnectedAccountCellView(connectedAccount: PreviewHelper.connectedAccount, isSelected: $isFirstSelected)
        ConnectedAccountCellView(connectedAccount: PreviewHelper.connectedAccount, isSelected: $isSecondSelected)
    }
}
