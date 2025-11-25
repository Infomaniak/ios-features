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
    func validateChallenge(uuid: String, approved: Bool) async throws(TwoFactorAuthError)
}

struct MockInAppTwoFactorAuthenticationFetcher: InAppTwoFactorAuthenticationFetchable {
    func latestChallenge() async throws -> RemoteChallenge? {
        RemoteChallenge.preview
    }

    func validateChallenge(uuid: String, approved: Bool) async throws(TwoFactorAuthError) {}
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

    func validateChallenge(uuid: String, approved: Bool) async throws(TwoFactorAuthError) {
        do {
            if approved {
                let request = apiFetcher.authenticatedRequest(.validateChallenge(uuid: uuid), method: .patch)
                let _: Empty = try await apiFetcher.perform(request: request, overrideDecoder: decoder)
            } else {
                let request = apiFetcher.authenticatedRequest(.validateChallenge(uuid: uuid), method: .delete)
                let _: Empty = try await apiFetcher.perform(request: request, overrideDecoder: decoder)
            }
        } catch let error as ErrorWithCode {
            throw TwoFactorAuthError(apiCode: error.code) ?? .unknown
        } catch let error as URLError {
            throw TwoFactorAuthError(networkError: error)
        } catch {
            throw TwoFactorAuthError.unknown
        }
    }
}
