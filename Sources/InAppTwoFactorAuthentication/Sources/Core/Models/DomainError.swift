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
import InfomaniakCoreUIResources

struct DomainError: Sendable, Error {
    let title: String
    let localizedDescription: String
    let apiCode: String?

    static let challengeExpired = DomainError(
        title: Localizable.twoFactorAuthExpiredErrorTitle,
        localizedDescription: Localizable.twoFactorAuthCheckOriginDescription,
        apiCode: "challenge_expired"
    )

    static let objectNotFound = DomainError(
        title: Localizable.twoFactorAuthAlreadyValidatedErrorTitle,
        localizedDescription: Localizable.twoFactorAuthCheckOriginDescription,
        apiCode: "object_not_found"
    )

    static let unknown = DomainError(
        title: CoreUILocalizable.anErrorHasOccurred,
        localizedDescription: Localizable.twoFactorAuthGenericErrorDescription
    )

    init(title: String, localizedDescription: String, apiCode: String? = nil) {
        self.title = title
        self.localizedDescription = localizedDescription
        self.apiCode = apiCode
    }

    init(networkError: URLError) {
        self.title = Localizable.twoFactorAuthNoNetworkErrorTitle
        self.localizedDescription = Localizable.twoFactorAuthNoNetworkErrorDescription
        self.apiCode = nil
    }

    init?(apiCode: String) {
        switch apiCode {
        case DomainError.challengeExpired.apiCode:
            self = .challengeExpired
        case DomainError.objectNotFound.apiCode:
            self = .objectNotFound
        default:
            return nil
        }
    }
}
