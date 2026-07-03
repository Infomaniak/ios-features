//
//  ContactCardManager.swift
//  ios-features
//
//  Created by Mushu on 6/30/26.
//

import Foundation

struct ContactCardManager {
    let rootPath: URL
    let folderName = "ContactCards"

    func save(contactCard: ContactCard, userId: Int) async {
        let rootPathL = rootPath.appending(path: folderName)
        let rootValidePath = rootPathL.path
        let isFound = FileManager.default.fileExists(atPath: rootValidePath)
        let encoder = JSONEncoder()

        do {
            if !isFound {
                try FileManager.default.createDirectory(
                    atPath: rootValidePath,
                    withIntermediateDirectories: true,
                    attributes: nil
                )
            }
            let jsonData = try encoder.encode(contactCard)
            let jsonFileURL = rootPathL.appending(path: "\(userId).json")

            try jsonData.write(to: jsonFileURL)

        } catch {
            print("ContactCard : catch save")
        }
    }

    func delete(userId: Int) async {
        let filePath = rootPath.appending(path: folderName).appending(path: "\(userId).json")
        do {
            try FileManager.default.removeItem(at: filePath)
        } catch {
            print("ContactCard : catch delete")
        }
    }

    func load(userId: Int) async -> ContactCard? {
        let rootPathL = rootPath.appending(path: folderName).appending(path: "\(userId).json")
        let decoder = JSONDecoder()
        do {
            let jsonData = try Data(contentsOf: rootPathL)
            return try decoder.decode(ContactCard.self, from: jsonData)
        } catch {
            print("ContactCard : catch load")
            return nil
        }
    }
}
