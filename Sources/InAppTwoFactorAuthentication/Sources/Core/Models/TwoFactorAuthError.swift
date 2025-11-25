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
import InfomaniakCoreUIResources
import SwiftUI

struct TwoFactorAuthError: Sendable, Error {
    let title: String
    let localizedDescription: String
    let apiCode: String?

    let headerColor: Color
    let headerImage: Image

    static let challengeExpired = TwoFactorAuthError(
        title: Localizable.twoFactorAuthExpiredErrorTitle,
        localizedDescription: Localizable.twoFactorAuthCheckOriginDescription,
        apiCode: "challenge_expired",
        headerColor: .ikOrange,
        headerImage: Image(.xmark)
    )

    static let objectNotFound = TwoFactorAuthError(
        title: Localizable.twoFactorAuthAlreadyProcessedErrorTitle,
        localizedDescription: Localizable.twoFactorAuthCheckOriginDescription,
        apiCode: "object_not_found",
        headerColor: .ikOrange,
        headerImage: Image(.deviceArrowRotate)
    )

    static let unknown = TwoFactorAuthError(
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
        case TwoFactorAuthError.challengeExpired.apiCode:
            self = .challengeExpired
        case TwoFactorAuthError.objectNotFound.apiCode:
            self = .objectNotFound
        default:
            return nil
        }
    }
}
