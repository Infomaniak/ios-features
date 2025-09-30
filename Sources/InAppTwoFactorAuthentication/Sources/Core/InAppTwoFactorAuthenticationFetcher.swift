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

import Alamofire
import Foundation
import InfomaniakCore
import InfomaniakCoreUIResources

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
    func latestChallenge() async throws -> RemoteChallenge?
    func validateChallenge(uuid: String, approved: Bool) async throws(DomainError)
}

struct MockInAppTwoFactorAuthenticationFetcher: InAppTwoFactorAuthenticationFetchable {
    func latestChallenge() async throws -> RemoteChallenge? {
        RemoteChallenge.preview
    }

    func validateChallenge(uuid: String, approved: Bool) async throws(DomainError) {}
}

struct InAppTwoFactorAuthenticationFetcher: InAppTwoFactorAuthenticationFetchable {
    let apiFetcher: ApiFetcher
    let decoder = JSONDecoder()

    init(apiFetcher: ApiFetcher) {
        self.apiFetcher = apiFetcher
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func latestChallenge() async throws -> RemoteChallenge? {
        let request = apiFetcher.authenticatedRequest(.latestChallenge)
        return try await apiFetcher.perform(request: request, overrideDecoder: decoder)
    }

    func validateChallenge(uuid: String, approved: Bool) async throws(DomainError) {
        do {
            if approved {
                let request = apiFetcher.authenticatedRequest(.validateChallenge(uuid: uuid), method: .patch)
                let _: Empty = try await apiFetcher.perform(request: request, overrideDecoder: decoder)
            } else {
                let request = apiFetcher.authenticatedRequest(.validateChallenge(uuid: uuid), method: .delete)
                let _: Empty = try await apiFetcher.perform(request: request, overrideDecoder: decoder)
            }
        } catch let error as ErrorWithCode {
            throw DomainError(apiCode: error.code) ?? .unknown
        } catch let error as URLError {
            throw DomainError(networkError: error)
        } catch {
            throw DomainError.unknown
        }
    }
}
