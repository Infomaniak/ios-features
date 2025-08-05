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
import InfomaniakCore
import InfomaniakCoreSwiftUI
import InfomaniakDI
import SwiftUI

public struct ContinueWithAccountView: View {
    @State private var isAccountShowingAccountSelections = false
    @State private var accounts: [ConnectedAccount]?
    @State private var selectedAccountIds = Set<Int>()

    private let isLoading: Bool
    private let excludingUserIds: [Int]
    private let onLoginPressed: () -> Void
    private let onLoginWithAccountsPressed: ([ConnectedAccount]) -> Void
    private let onCreateAccountPressed: () -> Void

    private var selectedAccounts: [ConnectedAccount] {
        accounts?.filter { selectedAccountIds.contains($0.userId) } ?? []
    }

    public init(isLoading: Bool,
                excludingUserIds: [Int] = [],
                onLoginPressed: @escaping () -> Void,
                onLoginWithAccountsPressed: @escaping ([ConnectedAccount]) -> Void,
                onCreateAccountPressed: @escaping () -> Void) {
        self.excludingUserIds = excludingUserIds
        self.isLoading = isLoading
        self.onLoginPressed = onLoginPressed
        self.onLoginWithAccountsPressed = onLoginWithAccountsPressed
        self.onCreateAccountPressed = onCreateAccountPressed
    }

    public var body: some View {
        VStack(spacing: IKPadding.mini) {
            if let accounts {
                if accounts.isEmpty {
                    Button(InterAppLoginLocalizable.Localizable.buttonLogin, action: onLoginPressed)
                        .buttonStyle(.ikBorderedProminent)
                        .ikButtonLoading(isLoading)

                    Button(InterAppLoginLocalizable.Localizable.buttonCreateAccount, action: onCreateAccountPressed)
                        .buttonStyle(.ikBorderless)
                        .disabled(isLoading)
                } else {
                    Button {
                        isAccountShowingAccountSelections.toggle()
                    } label: {
                        HStack(spacing: IKPadding.mini) {
                            ConnectedAccountAvatarStackView(accounts: selectedAccounts)

                            Text(InterAppLoginLocalizable.PluralLocalizable.selectedAccountCountLabel(selectedAccountIds.count))
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
                    .buttonStyle(.outlined)
                    .disabled(isLoading)

                    Button(InterAppLoginLocalizable.PluralLocalizable.buttonContinueWithAccounts(selectedAccountIds.count)) {
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

            selectedAccountIds = Set(accounts.compactMap(\.userId))

            withAnimation {
                self.accounts = accounts
            }
        }
        .floatingPanel(
            isPresented: $isAccountShowingAccountSelections,
            title: InterAppLoginLocalizable.Localizable.selectAccountPanelTitle,
            backgroundColor: .backgroundSecondary
        ) {
            SelectConnectedAccountListView(
                connectedAccounts: accounts ?? [],
                currentlySelectedAccountIds: selectedAccountIds,
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
