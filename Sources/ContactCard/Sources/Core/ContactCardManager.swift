/*
 Infomaniak Features - iOS
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

#if canImport(UIKit)
import Foundation

public struct ContactCardManager {
    let rootPath: URL
    let folderName = "ContactCards"

    public init(rootPath: URL) {
        self.rootPath = rootPath
    }

    public func save(contactCard: ContactCard, userId: Int) async throws {
        let folderURL = rootPath.appending(path: folderName)
        let encoder = JSONEncoder()

        if !FileManager.default.fileExists(atPath: folderURL.path) {
            try FileManager.default.createDirectory(
                at: folderURL,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }

        let jsonData = try encoder.encode(contactCard)
        try jsonData.write(to: folderURL.appending(path: "\(userId).json"))
    }

    public func delete(userId: Int) async throws {
        let filePath = rootPath.appending(path: folderName).appending(path: "\(userId).json")
        try FileManager.default.removeItem(at: filePath)
    }

    public func load(userId: Int) async throws -> ContactCard? {
        let filePath = rootPath.appending(path: folderName).appending(path: "\(userId).json")
        let decoder = JSONDecoder()

        let jsonData = try Data(contentsOf: filePath)
        return try decoder.decode(ContactCard.self, from: jsonData)
    }
}
#endif
