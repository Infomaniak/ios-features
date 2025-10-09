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
