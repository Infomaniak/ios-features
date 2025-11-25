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
