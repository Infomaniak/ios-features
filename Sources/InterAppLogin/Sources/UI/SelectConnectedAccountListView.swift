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
import InfomaniakCoreSwiftUI
import SwiftUI

struct SelectConnectedAccountListView: View {
    @Environment(\.dismiss) private var dismiss

    @Binding private var selectedAccountIds: Set<Int>

    private let connectedAccounts: [ConnectedAccount]
    private let onAddAccount: () -> Void

    init(connectedAccounts: [ConnectedAccount], selectedAccountIds: Binding<Set<Int>>, onAddAccount: @escaping () -> Void) {
        self.connectedAccounts = connectedAccounts
        _selectedAccountIds = selectedAccountIds
        self.onAddAccount = onAddAccount
    }

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: IKPadding.micro) {
                ForEach(connectedAccounts) { account in
                    ConnectedAccountCellView(connectedAccount: account, isSelected: Binding(get: {
                        selectedAccountIds.contains(account.userId)
                    }, set: { isSelected in
                        if isSelected {
                            selectedAccountIds.insert(account.userId)
                        } else {
                            selectedAccountIds.remove(account.userId)
                        }
                    }))
                    .padding(.horizontal, value: .medium)
                }
            }

            IKDivider()

            Button {
                dismiss()
                onAddAccount()
            } label: {
                HStack(spacing: IKPadding.medium) {
                    Image(systemName: "plus")
                        .iconSize(.large)
                        .foregroundStyle(.tint)

                    Text("!Add account")
                        .foregroundStyle(Color.Custom.textPrimary)
                        .font(.Custom.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(value: .medium)
            }
            .padding(.horizontal, value: .mini)

            Button("!Save") {}
                .buttonStyle(.ikBorderedProminent)
                .ikButtonFullWidth(true)
                .controlSize(.large)
                .padding(value: .medium)
        }
    }
}

#Preview {
    Text("Hello World")
        .floatingPanel(
            isPresented: .constant(true),
            title: "Select one or multiple accounts"
        ) {
            SelectConnectedAccountListView(
                connectedAccounts: [PreviewHelper.connectedAccount, PreviewHelper.connectedAccount2],
                selectedAccountIds: .constant([PreviewHelper.connectedAccount.userId]),
                onAddAccount: {}
            )
        }
}
