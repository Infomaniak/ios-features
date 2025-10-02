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
import SwiftUI

struct DomainError: Sendable, Error {
    let title: String
    let localizedDescription: String
    let apiCode: String?

    let headerColor: Color
    let headerImage: Image

    static let challengeExpired = DomainError(
        title: Localizable.twoFactorAuthExpiredErrorTitle,
        localizedDescription: Localizable.twoFactorAuthCheckOriginDescription,
        apiCode: "challenge_expired",
        headerColor: .ikOrange,
        headerImage: Image(.xmark)
    )

    static let objectNotFound = DomainError(
        title: Localizable.twoFactorAuthAlreadyValidatedErrorTitle,
        localizedDescription: Localizable.twoFactorAuthCheckOriginDescription,
        apiCode: "object_not_found",
        headerColor: .ikOrange,
        headerImage: Image(.deviceArrowRotate)
    )

    static let unknown = DomainError(
        title: CoreUILocalizable.anErrorHasOccurred,
        localizedDescription: Localizable.twoFactorAuthGenericErrorDescription,
        headerColor: .ikRed,
        headerImage: Image(.xmark)
    )

    init(title: String, localizedDescription: String, apiCode: String? = nil, headerColor: Color, headerImage: Image) {
        self.title = title
        self.localizedDescription = localizedDescription
        self.apiCode = apiCode
        self.headerColor = headerColor
        self.headerImage = headerImage
    }

    init(networkError: URLError) {
        title = Localizable.twoFactorAuthNoNetworkErrorTitle
        localizedDescription = Localizable.twoFactorAuthNoNetworkErrorDescription
        apiCode = nil
        headerColor = .ikOrange
        headerImage = Image(.wifiSlash)
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
