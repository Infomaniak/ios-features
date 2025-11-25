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
import OSLog

public actor MyKSuiteStore {
    public typealias UserId = Int

    let preferencesURL: URL
    let storeFileURL: URL

    var kSuites: [UserId: MyKSuite]?

    public init() {
        @InjectService var appGroupPathProvider: AppGroupPathProvidable
        preferencesURL = appGroupPathProvider.groupDirectoryURL.appendingPathComponent(
            "preferences/",
            isDirectory: true
        )
        storeFileURL = preferencesURL.appendingPathComponent("myKSuites.json")
    }

    @discardableResult
    public func updateMyKSuite(with apiFetcher: KSuiteApiFetchable, id: UserId) async throws -> MyKSuite {
        await loadIfNeeded()
        let myKSuite = try await apiFetcher.myKSuite()
        kSuites?[id] = myKSuite

        await save()

        return myKSuite
    }

    public func getMyKSuite(id: UserId) async -> MyKSuite? {
        await loadIfNeeded()
        return kSuites?[id]
    }

    public func removeMyKSuite(id: UserId) async {
        kSuites?.removeValue(forKey: id)
        await save()
    }

    private func save() async {
        let encoder = JSONEncoder()
        do {
            let kSuitesData = try encoder.encode(kSuites)
            try FileManager.default.createDirectory(atPath: preferencesURL.path, withIntermediateDirectories: true)
            try kSuitesData.write(to: storeFileURL)
        } catch {
            Logger.general.error("[MyKSuiteStore] Error saving accounts :\(error)")
        }
    }

    private func loadIfNeeded() async {
        guard kSuites == nil else {
            return
        }

        kSuites = [:]

        let decoder = JSONDecoder()

        do {
            let data = try Data(contentsOf: storeFileURL)
            let savedKSuites = try decoder.decode([UserId: MyKSuite].self, from: data)

            kSuites = savedKSuites
        } catch {
            Logger.general.error("[MyKSuiteStore] Error loading accounts :\(error)")
        }
    }
}
