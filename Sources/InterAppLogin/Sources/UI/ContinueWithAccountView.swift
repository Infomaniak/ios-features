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
    private let onLoginPressed: () -> Void
    private let onLoginWithAccountsPressed: ([ConnectedAccount]) -> Void
    private let onCreateAccountPressed: () -> Void

    public init(isLoading: Bool,
                onLoginPressed: @escaping () -> Void,
                onLoginWithAccountsPressed: @escaping ([ConnectedAccount]) -> Void,
                onCreateAccountPressed: @escaping () -> Void) {
        self.isLoading = isLoading
        self.onLoginPressed = onLoginPressed
        self.onLoginWithAccountsPressed = onLoginWithAccountsPressed
        self.onCreateAccountPressed = onCreateAccountPressed
    }

    public var body: some View {
        VStack {
            if let accounts {
                if accounts.isEmpty {
                    Button("!Login", action: onLoginPressed)
                        .buttonStyle(.ikBorderedProminent)
                        .ikButtonLoading(isLoading)

                    Button("!Create account", action: onCreateAccountPressed)
                        .buttonStyle(.ikBorderless)
                        .disabled(isLoading)
                } else {
                    Button {
                        isAccountShowingAccountSelections.toggle()
                    } label: {
                        HStack {
                            ConnectedAccountAvatarStackView(accounts: accounts)
                            Text("!\(selectedAccountIds.count) accounts selected")
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .buttonStyle(.ikBordered)
                    .disabled(isLoading)

                    Button("!Continue with this accounts") {
                        onLoginWithAccountsPressed(selectedAccountIds.compactMap { selectedAccountId in
                            accounts.first { account in
                                account.userId == selectedAccountId
                            }
                        })
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
            let accounts = await connectedAccountManager.listAllLocalAccounts()
            selectedAccountIds = Set(accounts.compactMap(\.userId))

            withAnimation {
                self.accounts = accounts
            }
        }
        .floatingPanel(
            isPresented: $isAccountShowingAccountSelections,
            title: "!Select one or multiple accounts"
        ) {
            SelectConnectedAccountListView(
                connectedAccounts: accounts ?? [],
                selectedAccountIds: $selectedAccountIds,
                onAddAccount: onLoginPressed
            )
        }
    }
}

@available(iOS 17, *)
#Preview("Accounts") {
    @Previewable @State var di = PreviewTargetAssembly(emptyAccounts: false)
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
}
