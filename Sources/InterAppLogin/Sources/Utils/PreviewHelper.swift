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
import InfomaniakLogin

struct PreviewTargetAssembly {
    init(emptyAccounts: Bool) {
        SimpleResolver.sharedResolver.store(factory: Factory(type: ConnectedAccountManagerable.self) { _, _ in
            PreviewConnectedAccountManager(emptyAccounts: emptyAccounts)
        })
    }
}

enum PreviewHelper {
    static var connectedAccount: ConnectedAccount {
        let fakeToken = ApiToken(
            accessToken: "",
            expiresIn: -1,
            refreshToken: "",
            scope: "",
            tokenType: "",
            userId: 1,
            expirationDate: Date()
        )

        let fakeUserProfile = UserProfile(
            id: 1,
            displayName: "John Appleseed",
            firstName: "John",
            lastName: "Appleseed",
            email: "mobiletest@ik.me",
            avatar: "https://avatar.storage.infomaniak.com/AXo01iecwUeoGoydY7WaCmmG.png?1717510064"
        )

        return ConnectedAccount(userId: 1, token: fakeToken, userProfile: fakeUserProfile)
    }

    static var connectedAccount2: ConnectedAccount {
        let fakeToken = ApiToken(
            accessToken: "",
            expiresIn: -1,
            refreshToken: "",
            scope: "",
            tokenType: "",
            userId: 2,
            expirationDate: Date()
        )

        let fakeUserProfile = UserProfile(
            id: 2,
            displayName: "Tim Cook",
            firstName: "Tim",
            lastName: "Cook",
            email: "timcook@ik.me"
        )

        return ConnectedAccount(userId: 2, token: fakeToken, userProfile: fakeUserProfile)
    }

    static var connectedAccount3: ConnectedAccount {
        let fakeToken = ApiToken(
            accessToken: "",
            expiresIn: -1,
            refreshToken: "",
            scope: "",
            tokenType: "",
            userId: 3,
            expirationDate: Date()
        )

        let fakeUserProfile = UserProfile(
            id: 3,
            displayName: "Craig Federighi",
            firstName: "Craig",
            lastName: "Federighi",
            email: "CraigFederighi@ik.me",
            avatar: "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fphotos5.appleinsider.com%2Farchive%2F12.08.27-Federighi.png&f=1&nofb=1&ipt=2283edd37fadae2e14e2f083e6f98b91a42d828845c5babd601bd8082fd9a9f4"
        )

        return ConnectedAccount(userId: 3, token: fakeToken, userProfile: fakeUserProfile)
    }

    static var allAccounts: [ConnectedAccount] {
        return [connectedAccount, connectedAccount2, connectedAccount3]
    }
}

struct PreviewConnectedAccountManager: ConnectedAccountManagerable {
    let emptyAccounts: Bool

    func listAllLocalAccounts() async -> [ConnectedAccount] {
        guard !emptyAccounts else {
            return []
        }
        return PreviewHelper.allAccounts
    }
}
