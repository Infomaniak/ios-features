//
//  ContactCardManager.swift
//  ios-features
//
//  Created by Mushu on 6/30/26.
//

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
