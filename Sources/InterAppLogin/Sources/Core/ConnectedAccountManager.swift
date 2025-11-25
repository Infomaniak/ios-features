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
