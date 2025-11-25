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
