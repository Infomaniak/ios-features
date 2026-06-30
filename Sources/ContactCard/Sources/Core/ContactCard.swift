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

import Contacts
import Foundation

@frozen public struct ContactCard: Codable, Hashable {
    public let id: Int
    public let firstName: String
    public let lastName: String
    public let email: String
    public let phone: String
    public let company: String?
    public let links: [ContactCardLink]?

    public init(
        id: Int,
        firstName: String,
        lastName: String,
        email: String,
        phone: String,
        company: String? = nil,
        links: [ContactCardLink]? = nil
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.company = company
        self.links = links
    }

    public func save() async -> Data {
        let encoder = JSONEncoder()
        do {
            return try encoder.encode(self)
        } catch {
            // TODO: Add logger
            return Data()
        }
    }

    public func loadIfNeed(jsonData: Data) async -> ContactCard? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(ContactCard.self, from: jsonData)
        } catch {
            // TODO: Add logger
            return nil
        }
    }

    public func makeVCardString() -> String {
        let website = links?.first(where: { $0.type == .website })?.url ?? ""
        let linkedIn = links?.first(where: { $0.type == .linkedIn })?.url ?? ""
        let twitter = links?.first(where: { $0.type == .twitter })?.url ?? ""
        let facebook = links?.first(where: { $0.type == .facebook })?.url ?? ""
        return """
        BEGIN:VCARD
        VERSION:3.0
        N:\(lastName);\(firstName);;;
        FN:\(firstName) \(lastName)
        ORG:\(company ?? "")
        TEL;TYPE=CELL:\(phone)
        EMAIL;TYPE=INTERNET:\(email)
        item1.URL:\(website)
        item1.X-ABLabel:Website
        item2.URL:\(linkedIn)
        item2.X-ABLabel:LinkedIn
        item3.URL:\(twitter)
        item3.X-ABLabel:Twitter
        item4.URL:\(facebook)
        item4.X-ABLabel:Facebook
        END:VCARD
        """
    }
}

public struct ContactCardLink: Codable, Hashable {
    public let type: ContactCardType
    public let url: String

    public init(
        type: ContactCardType,
        url: String
    ) {
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
