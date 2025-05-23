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

public struct MyKSuite: Codable, Sendable {
    let id: Int
    let drive: Drive
    let mail: Mail
    let trialExpiryAt: Int?

    public let isFree: Bool

    var icon: Image {
        if isFree {
            return MyKSuiteResources.Assets.myKSuiteLogo.swiftUIImage
        }
        return MyKSuiteResources.Assets.myKSuitePlusLogo.swiftUIImage
    }

    var formattedTrialExpiryDate: String? {
        guard let trialExpiryAt else { return nil }
        let date = Date(timeIntervalSince1970: TimeInterval(trialExpiryAt))

        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }

    public var email: String {
        mail.email
    }
}

struct Drive: Codable {
    let id: Int
    let name: String
    let size: Int64
    let usedSize: Int64
}

struct Mail: Codable {
    let id: Int
    let dailyLimitSent: Int
    let storageSizeLimit: Int64
    let email: String
    let usedSize: Int64
}
