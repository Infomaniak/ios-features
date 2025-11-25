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
import InfomaniakCore
import InfomaniakCoreSwiftUI
import InfomaniakDI
import SwiftUI

private struct OneAccountView: View {
    let account: ConnectedAccount

    var body: some View {
        HStack {
            ConnectedAccountAvatarView(connectedAccount: account)

            VStack(alignment: .leading, spacing: 0) {
                Text(account.userProfile.displayName)
                    .font(.Custom.headline)
                    .foregroundStyle(Color.Custom.textPrimary)
                Text(account.userProfile.email)
                    .font(.Custom.body)
                    .foregroundStyle(Color.Custom.textSecondary)
            }
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .center)

            CenteringPlaceholderAvatarStackView(accounts: [account])
                .overlay(alignment: .trailing) {
                    Image(.chevronDown)
                        .iconSize(.medium)
                        .foregroundStyle(.tint)
                }
        }
        .padding(.vertical, value: .mini)
    }
}

struct ManyAccountView: View {
    let selectedAccounts: [ConnectedAccount]

    init(selectedAccounts: [ConnectedAccount]) {
        self.selectedAccounts = selectedAccounts
    }

    var body: some View {
        HStack(spacing: IKPadding.mini) {
            ConnectedAccountAvatarStackView(accounts: selectedAccounts)

            Text(InterAppLoginLocalizable.selectedAccountCountLabel(selectedAccounts.count))
                .frame(maxWidth: .infinity)
                .lineLimit(1)

            CenteringPlaceholderAvatarStackView(accounts: selectedAccounts)
                .overlay(alignment: .trailing) {
                    Image(.chevronDown)
                        .iconSize(.medium)
                        .foregroundStyle(.tint)
                }
        }
    }
}

public struct ContinueWithAccountView: View {
    @State private var isShowingAccountsSelection = false
    @State private var accounts: [ConnectedAccount]?
    @State private var selectedAccountIds = Set<Int>()

    private let isLoading: Bool
    private let excludingUserIds: [Int]
    private let allowsMultipleSelection: Bool
    private let onLoginPressed: () -> Void
    private let onLoginWithAccountsPressed: ([ConnectedAccount]) -> Void
    private let onCreateAccountPressed: () -> Void

    private var selectedAccounts: [ConnectedAccount] {
        accounts?.filter { selectedAccountIds.contains($0.userId) } ?? []
    }

    private var selectAccountPanelTitle: String {
        allowsMultipleSelection ?
            InterAppLoginLocalizable.selectAccountPanelTitle :
            InterAppLoginLocalizable.selectSingleAccountPanelTitle
    }

    public init(isLoading: Bool,
                excludingUserIds: [Int] = [],
                allowsMultipleSelection: Bool = true,
                onLoginPressed: @escaping () -> Void,
                onLoginWithAccountsPressed: @escaping ([ConnectedAccount]) -> Void,
                onCreateAccountPressed: @escaping () -> Void) {
        self.isLoading = isLoading
        self.excludingUserIds = excludingUserIds
        self.allowsMultipleSelection = allowsMultipleSelection
        self.onLoginPressed = onLoginPressed
        self.onLoginWithAccountsPressed = onLoginWithAccountsPressed
        self.onCreateAccountPressed = onCreateAccountPressed
    }

    public var body: some View {
        VStack(spacing: IKPadding.mini) {
            if let accounts {
                if accounts.isEmpty {
                    Button(InterAppLoginLocalizable.buttonLogin, action: onLoginPressed)
                        .buttonStyle(.ikBorderedProminent)
                        .ikButtonLoading(isLoading)

                    Button(InterAppLoginLocalizable.buttonCreateAccount, action: onCreateAccountPressed)
                        .buttonStyle(.ikBorderless)
                        .disabled(isLoading)
                } else {
                    Button {
                        isShowingAccountsSelection.toggle()
                    } label: {
                        if accounts.count == 1 || selectedAccountIds.count == 1, let selectedAccount = selectedAccounts.first {
                            OneAccountView(account: selectedAccount)
                        } else {
                            ManyAccountView(selectedAccounts: selectedAccounts)
                        }
                    }
                    .buttonStyle(.outlined)
                    .disabled(isLoading)

                    Button(InterAppLoginLocalizable.buttonContinueWithAccounts(selectedAccountIds.count)) {
                        onLoginWithAccountsPressed(selectedAccounts)
                    }
                    .buttonStyle(.ikBorderedProminent)
                    .ikButtonLoading(isLoading)
                }
            } else {
                ProgressView()
            }
        }
        .ikButtonFullWidth(true)
        .controlSize(.large)
        .task {
            @InjectService var connectedAccountManager: ConnectedAccountManagerable
            var accounts = await connectedAccountManager.listAllLocalAccounts()
            accounts = accounts.filter { connectedAccount in
                !excludingUserIds.contains(connectedAccount.userId)
            }

            if allowsMultipleSelection {
                selectedAccountIds = Set(accounts.compactMap(\.userId))
            } else if let firstAccount = accounts.first {
                selectedAccountIds = [firstAccount.userId]
            }

            withAnimation {
                self.accounts = accounts
            }
        }
        .floatingPanel(
            isPresented: $isShowingAccountsSelection,
            title: selectAccountPanelTitle,
            backgroundColor: .backgroundSecondary
        ) {
            SelectConnectedAccountListView(
                connectedAccounts: accounts ?? [],
                currentlySelectedAccountIds: selectedAccountIds,
                allowsMultipleSelection: allowsMultipleSelection,
                onAddAccount: onAddAccountPressed,
                onSelectedAccountSaved: onSelectedAccountSaved
            )
        }
    }

    private func onAddAccountPressed() {
        Task { @MainActor in
            // We have to wait for closing animation before opening the login WebView modally
            try await Task.sleep(nanoseconds: 500_000_000)
            onLoginPressed()
        }
    }

    private func onSelectedAccountSaved(_ selectedAccountIds: Set<Int>) {
        withAnimation {
            self.selectedAccountIds = selectedAccountIds
        }
    }
}

@available(iOS 17, *)
#Preview("Accounts") {
    @Previewable @State var di = PreviewTargetAssembly(emptyAccounts: false)
    VStack(spacing: IKPadding.huge) {
        ContinueWithAccountView(
            isLoading: false,
            onLoginPressed: {},
            onLoginWithAccountsPressed: { _ in },
            onCreateAccountPressed: {}
        )
        ContinueWithAccountView(
            isLoading: true,
            onLoginPressed: {},
            onLoginWithAccountsPressed: { _ in },
            onCreateAccountPressed: {}
        )
    }
    .padding()
}

@available(iOS 17, *)
#Preview("No accounts") {
    @Previewable @State var di = PreviewTargetAssembly(emptyAccounts: true)
    VStack {
        ContinueWithAccountView(
            isLoading: false,
            onLoginPressed: {},
            onLoginWithAccountsPressed: { _ in },
            onCreateAccountPressed: {}
        )
        ContinueWithAccountView(
            isLoading: true,
            onLoginPressed: {},
            onLoginWithAccountsPressed: { _ in },
            onCreateAccountPressed: {}
        )
    }
    .padding()
}
