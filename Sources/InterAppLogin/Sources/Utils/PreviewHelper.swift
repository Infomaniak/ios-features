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
import InfomaniakLogin

struct PreviewTargetAssembly {
    init() {
        SimpleResolver.sharedResolver.store(factory: Factory(type: ConnectedAccountManagerable.self) { _, _ in
            PreviewConnectedAccountManager()
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
            userId: 1,
            expirationDate: Date()
        )

        let fakeUserProfile = UserProfile(
            id: 1,
            displayName: "Tim Cook",
            firstName: "Tim",
            lastName: "Cook",
            email: "timcook@ik.me"
        )

        return ConnectedAccount(userId: 1, token: fakeToken, userProfile: fakeUserProfile)
    }
}

struct PreviewConnectedAccountManager: ConnectedAccountManagerable {
    func listAllLocalAccounts() async -> [ConnectedAccount] {
        return [PreviewHelper.connectedAccount]
    }
}
