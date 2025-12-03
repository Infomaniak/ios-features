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
import InfomaniakCoreSwiftUI
import InfomaniakCoreUIResources
import SwiftUI

struct SelectConnectedAccountListView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var selectedAccountIds: Set<Int>

    private let connectedAccounts: [ConnectedAccount]
    private let allowsMultipleSelection: Bool
    private let onAddAccount: () -> Void
    private let onSelectedAccountSaved: (Set<Int>) -> Void

    init(connectedAccounts: [ConnectedAccount],
         currentlySelectedAccountIds: Set<Int>,
         allowsMultipleSelection: Bool,
         onAddAccount: @escaping () -> Void,
         onSelectedAccountSaved: @escaping (Set<Int>) -> Void) {
        self.connectedAccounts = connectedAccounts
        self.allowsMultipleSelection = allowsMultipleSelection
        _selectedAccountIds = State(wrappedValue: currentlySelectedAccountIds)
        self.onAddAccount = onAddAccount
        self.onSelectedAccountSaved = onSelectedAccountSaved
    }

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: IKPadding.micro) {
                ForEach(connectedAccounts) { account in
                    ConnectedAccountCellView(connectedAccount: account, isSelected: Binding(get: {
                        selectedAccountIds.contains(account.userId)
                    }, set: { isSelected in
                        if isSelected {
                            if allowsMultipleSelection {
                                selectedAccountIds.insert(account.userId)
                            } else {
                                selectedAccountIds = [account.userId]
                            }
                        } else if selectedAccountIds.count > 1 {
                            selectedAccountIds.remove(account.userId)
                        }
                    }))
                    .padding(.horizontal, value: .medium)
                }
            }

            Divider()
                .frame(height: 1)
                .overlay(Color.Custom.divider)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))

            Button {
                dismiss()
                onAddAccount()
            } label: {
                HStack(spacing: IKPadding.medium) {
                    Image(.personCirclePlusFilled)
                        .iconSize(.large)
                        .foregroundStyle(.tint)

                    Text(InterAppLoginLocalizable.buttonUseOtherAccount)
                        .foregroundStyle(Color.Custom.textPrimary)
                        .font(.Custom.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(value: .medium)
            }
            .padding(.horizontal, value: .mini)

            Button(CoreUILocalizable.buttonSave) {
                dismiss()
                onSelectedAccountSaved(selectedAccountIds)
            }
            .buttonStyle(.ikBorderedProminent)
            .ikButtonFullWidth(true)
            .controlSize(.large)
            .padding(value: .medium)
        }
    }
}

#Preview("Multi Selection") {
    Text("Hello World")
        .floatingPanel(
            isPresented: .constant(true),
            title: "Select one or multiple accounts",
            backgroundColor: .backgroundSecondary
        ) {
            SelectConnectedAccountListView(
                connectedAccounts: [PreviewHelper.connectedAccount, PreviewHelper.connectedAccount2],
                currentlySelectedAccountIds: [PreviewHelper.connectedAccount.userId],
                allowsMultipleSelection: true,
                onAddAccount: {},
                onSelectedAccountSaved: { _ in }
            )
        }
}

#Preview("Single Selection") {
    Text("Hello World")
        .floatingPanel(
            isPresented: .constant(true),
            title: "Select one account",
            backgroundColor: .backgroundSecondary
        ) {
            SelectConnectedAccountListView(
                connectedAccounts: [PreviewHelper.connectedAccount, PreviewHelper.connectedAccount2],
                currentlySelectedAccountIds: [PreviewHelper.connectedAccount.userId],
                allowsMultipleSelection: false,
                onAddAccount: {},
                onSelectedAccountSaved: { _ in }
            )
        }
}
