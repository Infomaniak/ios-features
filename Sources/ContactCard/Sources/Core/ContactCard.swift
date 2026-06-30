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

    public func makeVCardString(photoData: PlatformImage? = nil) -> String {
        let website = links?.first(where: { $0.type == .website })?.url ?? ""
        let linkedIn = links?.first(where: { $0.type == .linkedIn })?.url ?? ""
        let twitter = links?.first(where: { $0.type == .twitter })?.url ?? ""
        let facebook = links?.first(where: { $0.type == .facebook })?.url ?? ""

        var base64String: String? = nil

        if let photoData,
           let imageData = photoData.jpegData(compressionQuality: 1.0) {
            base64String = imageData.base64EncodedString()
        }

        let photoLine: String
        if let base64String {
            photoLine = "PHOTO;ENCODING=b;TYPE=JPEG:\(base64String)\r\n"
        } else {
            photoLine = ""
        }

        return "BEGIN:VCARD\r\nVERSION:3.0\r\nN:\(lastName);\(firstName);;;\r\nFN:\(firstName) \(lastName)\r\nORG:\(company ?? "")\r\nTEL;TYPE=CELL:\(phone)\r\nEMAIL;TYPE=INTERNET:\(email)\r\n\(photoLine)item1.URL:\(website)\r\nitem1.X-ABLabel:Website\r\nitem2.URL:\(linkedIn)\r\nitem2.X-ABLabel:LinkedIn\r\nitem3.URL:\(twitter)\r\nitem3.X-ABLabel:Twitter\r\nitem4.URL:\(facebook)\r\nitem4.X-ABLabel:Facebook\r\nEND:VCARD"
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
    case twitter
    case facebook
    case website
}
