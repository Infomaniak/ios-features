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

extension KeychainHelper {
    static let appIdentifierBuilder = AppIdentifierBuilder(teamId: "864VDCS2QY")
    static let driveKeychainIdentifier = appIdentifierBuilder.keychainAccessGroupFor(identifier: "com.infomaniak.drive")
    static let mailKeychainIdentifier = appIdentifierBuilder.keychainAccessGroupFor(identifier: "com.infomaniak.mail")

    static let knownAppKeychainIdentifiers = [driveKeychainIdentifier, mailKeychainIdentifier]
}

public struct AppIdentifierBuilder: Sendable {
    let teamId: String

    /// - Parameter teamId: Team ID of the Apple Developer account eg. For IK 864VDCS2QY. (this is ID is public)
    public init(teamId: String) {
        self.teamId = teamId
    }

    /// Construct a valid keychain access group.
    /// - Parameter identifier: The identifier declared in the entitlement file (Keychain Sharing section).
    /// - Returns: An access group ready for use in by the Keychain as kSecAttrAccessGroup.
    public func keychainAccessGroupFor(identifier: String) -> String {
        "\(teamId)\(identifier)"
    }

    /// Construct a valid app group identifier.
    /// - Parameter identifier: The identifier declared in the entitlement file (App Groups section).
    /// - Returns: An app group ready for use with FileManager.containerURL(forSecurityApplicationGroupIdentifier: )
    public func appGroupFor(identifier: String) -> String {
        "group.\(identifier)"
    }
}

public struct ConnectedAccount: Identifiable {
    public var id: Int {
        return userId
    }

    public let userId: Int
    public let token: ApiToken
    public let userProfile: UserProfile
}

protocol ConnectedAccountManagerable {
    func listAllLocalAccounts() async -> [ConnectedAccount]
}

public protocol ProfileApiFetchable {
    func userProfile(ignoreDefaultAvatar: Bool, dateFormat: DateFormat) async throws -> UserProfile
}

extension ApiFetcher: ProfileApiFetchable {}

public struct ConnectedAccountManager: ConnectedAccountManagerable {
    let currentAppKeychainIdentifier: String
    let refreshTokenDelegate = NoRefreshTokenDelegate()

    init(currentAppKeychainIdentifier: String) {
        self.currentAppKeychainIdentifier = currentAppKeychainIdentifier
    }

    public func listAllLocalAccounts() async -> [ConnectedAccount] {
        var accounts: [ConnectedAccount] = []

        for keychainIdentifier in KeychainHelper.knownAppKeychainIdentifiers {
            if keychainIdentifier == currentAppKeychainIdentifier {
                continue
            }

            let apiTokens = KeychainHelper(accessGroup: keychainIdentifier).loadTokens()

            for apiToken in apiTokens {
                if !accounts.contains(where: { $0.userId == apiToken.userId }) {
                    let apiFetcher = ApiFetcher()
                    apiFetcher.createAuthenticatedSession(
                        apiToken,
                        authenticator: OAuthAuthenticator(refreshTokenDelegate: refreshTokenDelegate)
                    )

                    guard let userProfile = try? await apiFetcher.userProfile(ignoreDefaultAvatar: true, dateFormat: .iso8601)
                    else {
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
