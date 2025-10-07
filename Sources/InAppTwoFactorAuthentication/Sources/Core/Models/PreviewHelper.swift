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
import InfomaniakDI

struct PreviewTargetAssembly {
    init() {
        SimpleResolver.sharedResolver.store(factory: Factory(type: PlatformDetectable.self) { _, _ in
            PlatformDetector()
        })
        SimpleResolver.sharedResolver.store(factory: Factory(type: InAppTwoFactorAuthenticationManagerable.self) { _, _ in
            InAppTwoFactorAuthenticationManager()
        })
    }
}

extension RemoteChallenge {
    static let preview = RemoteChallenge(
        uuid: "aa",
        type: .approval,
        device: Device(name: "iPhone 17", type: .phone),
        location: "Switzerland",
        createdAt: Date(timeIntervalSinceNow: -2 * 60),
        expiresAt: Date(timeIntervalSinceNow: 10 * 60)
    )
}

struct PreviewUser: InfomaniakUser {
    var id: Int
    var email: String
    var displayName: String
    var avatar: String?

    static let preview = PreviewUser(
        id: 1,
        email: "CraigFederighi@ik.me",
        displayName: "Craig Federighi",
        avatar: "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fphotos5.appleinsider.com%2Farchive%2F12.08.27-Federighi.png&f=1&nofb=1&ipt=2283edd37fadae2e14e2f083e6f98b91a42d828845c5babd601bd8082fd9a9f4"
    )
    static let previewNoAvatar = PreviewUser(id: 2, email: "tcook@apple.com", displayName: "Tim Cook", avatar: nil)
}

extension InAppTwoFactorAuthenticationSession {
    static let preview = InAppTwoFactorAuthenticationSession(
        user: PreviewUser.preview,
        apiFetcher: MockInAppTwoFactorAuthenticationFetcher()
    )
}
