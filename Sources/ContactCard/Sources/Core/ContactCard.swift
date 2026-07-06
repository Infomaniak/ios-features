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

import Foundation
import Nuke
import NukeUI

@frozen public struct ContactCard: Codable, Hashable {
    public let id: Int
    public let firstName: String
    public let lastName: String
    public let email: String
    public let phone: String
    public let company: String?
    public let avatarURL: String?
    public let links: [ContactCardLink]?

    public init(
        id: Int,
        firstName: String,
        lastName: String,
        email: String,
        phone: String,
        company: String? = nil,
        avatarURL: String? = nil,
        links: [ContactCardLink]? = nil
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.company = company
        self.avatarURL = avatarURL
        self.links = links
    }

    public func makeVCardString(forQRCode qrCodeParentScreen: Bool = false, photoData: PlatformImage? = nil) -> String {
        var base64String: String?
        if let photoData,
           !qrCodeParentScreen,
           let imageData = photoData.jpegData(compressionQuality: 1.0) {
            base64String = imageData.base64EncodedString()
        }

        let photoLine = base64String.map { "PHOTO;ENCODING=b;TYPE=JPEG:\($0)\r\n" } ?? ""

        var urlLines = ""
        for (index, link) in (links ?? []).filter({ !$0.url.isEmpty }).enumerated() {
            let item = index + 1
            urlLines += "item\(item).URL:\(link.url)\r\nitem\(item).X-ABLabel:\(link.type.vCardLabel)\r\n"
        }

        return "BEGIN:VCARD\r\nVERSION:3.0\r\nN:\(lastName);\(firstName);;;\r\nFN:\(firstName) \(lastName)\r\nORG:\(company ?? "")\r\nTEL;TYPE=CELL:\(phone)\r\nEMAIL;TYPE=INTERNET:\(email)\r\n\(photoLine)\(urlLines)END:VCARD"
    }
}

public struct ContactCardLink: Codable, Hashable {
    public let type: ContactCardType
    public let url: String

    public init(type: ContactCardType, url: String) {
        self.type = type
        self.url = url
    }
}

public enum ContactCardType: String, Codable {
    case linkedIn
    case x
    case instagram
    case facebook
    case website
    case other

    public var vCardLabel: String {
        switch self {
        case .linkedIn: return "LinkedIn"
        case .x: return "Twitter"
        case .instagram: return "Instagram"
        case .facebook: return "Facebook"
        case .website: return "Website"
        case .other: return "URL"
        }
    }
}
