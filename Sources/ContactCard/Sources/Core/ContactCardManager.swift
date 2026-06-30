//
//  ContactCardManager.swift
//  ios-features
//
//  Created by Mushu on 6/30/26.
//

import Foundation

struct ContactCardManager {
    let rootPath: URL
    let folderName = "contactcards"

    func save(contactCard: ContactCard, userId: Int) async {
        let rootPathL = rootPath.appending(path: folderName)
        let isFound = FileManager.default.fileExists(atPath: rootPathL.absoluteString)
        let encoder = JSONEncoder()

        do {
            if !isFound {
                try FileManager.default.createDirectory(
                    atPath: rootPathL.absoluteString,
                    withIntermediateDirectories: true,
                    attributes: nil
                )
            }
            let jsonData = try encoder.encode(contactCard)
            let jsonFileURL = rootPathL.appending(path: "\(userId).json")

            try jsonData.write(to: jsonFileURL)

        } catch {
            // TODO: Add logger
        }
    }

    func load(userId: Int) async -> ContactCard? {
        let rootPathL = rootPath.appending(path: folderName).appending(path: "\(userId).json")
        let decoder = JSONDecoder()
        do {
            let jsonData = try Data(contentsOf: rootPathL)
            return try decoder.decode(ContactCard.self, from: jsonData)
        } catch {
            // TODO: Add logger
            return nil
        }
    }
}
