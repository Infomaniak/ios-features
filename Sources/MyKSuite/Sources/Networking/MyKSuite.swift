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

import SwiftUI

public struct MyKSuite: Codable, Sendable {
    let id: Int
    let drive: Drive
    let mail: Mail
    let trialExpiryAt: Int?

    public let isFree: Bool

    var icon: Image {
        if isFree {
            return MyKSuiteResources.myKSuiteLogo.swiftUIImage
        }
        return MyKSuiteResources.myKSuitePlusLogo.swiftUIImage
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
