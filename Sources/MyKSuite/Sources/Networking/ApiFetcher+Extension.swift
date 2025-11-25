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

public protocol KSuiteApiFetchable {
    func myKSuite() async throws -> MyKSuite
}

extension Endpoint {
    static func myKSuite() -> Endpoint {
        return Endpoint(path: "/1/my_ksuite/current",
                        queryItems: [
                            URLQueryItem(name: "with", value: "drive,mail")
                        ])
    }
}

extension ApiFetcher: KSuiteApiFetchable {
    public func myKSuite() async throws -> MyKSuite {
        return try await perform(request: authenticatedRequest(.myKSuite()))
    }
}
