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
