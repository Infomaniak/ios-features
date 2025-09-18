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

import Foundation
import InfomaniakCore
import InfomaniakLogin

public struct ConnectedAccount: Identifiable, Sendable {
    public var id: Int {
        return userId
    }

    public let userId: Int
    public let token: ApiToken
    public let userProfile: UserProfile
}

public protocol ProfileApiFetchable {
    func userProfile(ignoreDefaultAvatar: Bool, dateFormat: DateFormat) async throws -> UserProfile
}

extension ApiFetcher: ProfileApiFetchable {}

public protocol ConnectedAccountManagerable {
    func listAllLocalAccounts() async -> [ConnectedAccount]
}

public struct ConnectedAccountManager: ConnectedAccountManagerable {
    let currentAppKeychainIdentifier: String
    let knownAppKeychainIdentifiers: [String]
    let refreshTokenDelegate = NoRefreshTokenDelegate()

    public init(
        currentAppKeychainIdentifier: String,
        knownAppKeychainIdentifiers: [String] = AppIdentifierBuilder.knownAppKeychainIdentifiers
    ) {
        self.currentAppKeychainIdentifier = currentAppKeychainIdentifier
        self.knownAppKeychainIdentifiers = knownAppKeychainIdentifiers
    }

    public func listAllLocalAccounts() async -> [ConnectedAccount] {
        var accounts: [ConnectedAccount] = []

        for keychainIdentifier in knownAppKeychainIdentifiers {
            if keychainIdentifier == currentAppKeychainIdentifier {
                continue
            }

            let apiTokens = KeychainHelper(accessGroup: keychainIdentifier).loadTokens().map { $0.apiToken }

            for apiToken in apiTokens {
                if !accounts.contains(where: { $0.userId == apiToken.userId }) {
                    let apiFetcher = ApiFetcher()
                    apiFetcher.createAuthenticatedSession(
                        apiToken,
                        authenticator: OAuthAuthenticator(refreshTokenDelegate: refreshTokenDelegate)
                    )

                    guard let userProfile = try? await apiFetcher.userProfile(ignoreDefaultAvatar: true) else {
                        continue
                    }
                    accounts.append(ConnectedAccount(userId: apiToken.userId, token: apiToken, userProfile: userProfile))
                }
            }
        }

        return accounts
    }
}

class NoRefreshTokenDelegate: RefreshTokenDelegate {
    func didUpdateToken(newToken: ApiToken, oldToken: ApiToken) {}

    func didFailRefreshToken(_ token: ApiToken) {}
}
