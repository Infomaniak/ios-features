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

import SwiftUI

@MainActor
public struct MyKSuite: Codable, Sendable {
    let id: Int
    let status: String
    let packId: Int
    let pack: Pack
    let isFree: Bool
    let drive: Drive
    let freeMail: FreeMail
    let hasAutoRenew: Bool

    var icon: Image {
        if isFree {
            return ImageHelper.myKSuiteLogo
        }
        return ImageHelper.myKSuitePlusLogo
    }
}

struct Pack: Codable {
    let id: Int
    let name: String
    let driveStorage: Int
    let mailStorage: Int
    let mailDailyLimitSend: Int
    let isMaxStorageOffer: Bool
}

struct Drive: Codable {
    let id: Int
    let name: String
    let size: Int64
    let usedSize: Int64
}

struct FreeMail: Codable {
    let id: Int
    let dailyLimitSent: Int
    let storageSizeLimit: Int64
    let email: String
    let usedSize: Int64
}
