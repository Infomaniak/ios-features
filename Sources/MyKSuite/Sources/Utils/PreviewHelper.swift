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
import InfomaniakCore
import InfomaniakDI

enum PreviewHelper {
    static let sampleMail = Mail(
        id: 343_334,
        dailyLimitSent: 500,
        storageSizeLimit: 21_474_836_480,
        email: "ksuitemombile@ik.me",
        usedSize: 27
    )

    static let sampleDrive = Drive(
        id: 15,
        name: "Le drive",
        size: 16_106_127_360,
        usedSize: 656_438
    )

    static let sampleMyKSuite = MyKSuite(
        id: 81,
        drive: sampleDrive,
        mail: sampleMail,
        trialExpiryAt: 1_769_814_000,
        isFree: true
    )
}

class PreviewKSuiteFetcher: KSuiteApiFetchable {
    func myKSuite() async throws -> MyKSuite {
        PreviewHelper.sampleMyKSuite
    }
}

class PreviewAppGroupPathProvider: AppGroupPathProvidable {
    var groupDirectoryURL: URL

    var realmRootURL: URL

    var importDirectoryURL: URL

    var cacheDirectoryURL: URL

    var tmpDirectoryURL: URL

    var openInPlaceDirectoryURL: URL?

    required init(realmRootPath: String, appGroupIdentifier: String) {
        groupDirectoryURL = FileManager.default.temporaryDirectory
        realmRootURL = FileManager.default.temporaryDirectory
        importDirectoryURL = FileManager.default.temporaryDirectory
        cacheDirectoryURL = FileManager.default.temporaryDirectory
        tmpDirectoryURL = FileManager.default.temporaryDirectory
        openInPlaceDirectoryURL = FileManager.default.temporaryDirectory
    }
}

struct PreviewTargetAssembly {
    init() {
        SimpleResolver.sharedResolver.store(factory: Factory(type: AppGroupPathProvidable.self) { _, _ in
            return PreviewAppGroupPathProvider(realmRootPath: "", appGroupIdentifier: "")
        })
        SimpleResolver.sharedResolver.store(factory: Factory(type: MyKSuiteStore.self) { _, _ in
            MyKSuiteStore()
        })
    }
}
