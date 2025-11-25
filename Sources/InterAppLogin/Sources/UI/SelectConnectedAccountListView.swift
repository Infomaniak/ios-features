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
