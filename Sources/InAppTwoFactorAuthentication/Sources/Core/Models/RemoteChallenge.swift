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

enum DeviceType: String, Decodable {
    case computer
    case phone
    case tablet
}

struct Device: Decodable {
    let name: String
    let type: DeviceType
}

enum ChallengeType: String, Decodable {
    case approval
    case unknown

    init(from decoder: any Decoder) throws {
        let singleKeyContainer = try decoder.singleValueContainer()
        let value = try singleKeyContainer.decode(String.self)

        self = ChallengeType(rawValue: value) ?? .unknown
    }
}

struct RemoteChallenge: Decodable {
    let uuid: String
    let type: ChallengeType
    let device: Device
    let location: String
    let createdAt: Date
    let expiresAt: Date
}
