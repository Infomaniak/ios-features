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

import InfomaniakCore

public struct InAppTwoFactorAuthenticationSession {
    let user: InfomaniakUser
    let apiFetcher: any InAppTwoFactorAuthenticationFetchable

    public init(user: InfomaniakUser, apiFetcher: ApiFetcher) {
        self.user = user
        self.apiFetcher = InAppTwoFactorAuthenticationFetcher(apiFetcher: apiFetcher)
    }

    init(user: InfomaniakUser, apiFetcher: MockInAppTwoFactorAuthenticationFetcher) {
        self.user = user
        self.apiFetcher = apiFetcher
    }
}
