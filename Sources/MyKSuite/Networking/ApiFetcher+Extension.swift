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

extension Endpoint {
    static func myKSuite() -> Endpoint {
        return Endpoint(host: "api.staging-myksuite.dev.infomaniak.ch", path: "/1/my_ksuite/current", queryItems: [
            URLQueryItem(name: "with", value: "*")
        ])
    }
}

extension ApiFetcher {
    private var myKSuiteDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }

    func myKSuite() async throws -> MyKSuite {
        let endpoint = Endpoint.myKSuite()

        let header = HTTPHeader(name: "Authorization", value: "Bearer \(currentToken?.accessToken ?? "")")
        return try await perform(request: AF.request(
            endpoint.url,
            headers: HTTPHeaders([header])
        ))
    }
}
