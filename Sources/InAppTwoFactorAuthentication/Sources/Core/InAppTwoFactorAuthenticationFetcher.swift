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

extension ApiEnvironment {
    var loginHost: String {
        return "login.\(host)"
    }
}

extension Endpoint {
    static func validateChallenge(uuid: String) -> Endpoint {
        return Endpoint(hostKeypath: \.loginHost, path: "/api/2fa/push/challenges/\(uuid)")
    }

    static var latestChallenge: Endpoint {
        return Endpoint(hostKeypath: \.loginHost, path: "/api/2fa/push/challenges")
    }
}

protocol InAppTwoFactorAuthenticationFetchable {
    func latestChallenge() async throws -> RemoteChallenge
    func validateChallenge(uuid: String, approved: Bool) async throws -> Bool
}

struct MockInAppTwoFactorAuthenticationFetcher: InAppTwoFactorAuthenticationFetchable {
    func latestChallenge() async throws -> RemoteChallenge {
        RemoteChallenge.preview
    }

    func validateChallenge(uuid: String, approved: Bool) async throws -> Bool {
        return true
    }
}

struct InAppTwoFactorAuthenticationFetcher: InAppTwoFactorAuthenticationFetchable {
    let apiFetcher: ApiFetcher

    func latestChallenge() async throws -> RemoteChallenge {
        let request = apiFetcher.authenticatedRequest(.latestChallenge)
        return try await apiFetcher.perform(request: request)
    }

    func validateChallenge(uuid: String, approved: Bool) async throws -> Bool {
        let parameters = RemoteChallengeValidation(uuid: uuid, approved: approved)
        let request = apiFetcher.authenticatedRequest(.validateChallenge(uuid: uuid), method: .patch, parameters: parameters)
        return try await apiFetcher.perform(request: request)
    }
}
