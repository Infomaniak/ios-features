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

import ContactCard
import Foundation
import XCTest

private extension ContactCard {
    static let sample = ContactCard(
        id: 42,
        firstName: "John",
        lastName: "Doe",
        email: "john.doe@example.com",
        phone: "+33 612-345-678",
        company: "Infomaniak",
        links: [
            ContactCardLink(type: .website, url: "https://www.john.doe.com/"),
            ContactCardLink(type: .linkedIn, url: "https://www.linkedin.com/john.doe")
        ]
    )

    static let minimal = ContactCard(
        id: 1,
        firstName: "Jane",
        lastName: "Smith",
        email: "jane@example.com",
        phone: "0000000000"
    )
}

// MARK: - ContactCard Tests

final class ContactCardTest: XCTestCase {
    // MARK: makeVCardString

    func testVCardContainsRequiredFields() {
        let vcf = ContactCard.sample.makeVCardString()

        XCTAssertTrue(vcf.contains("BEGIN:VCARD"))
        XCTAssertTrue(vcf.contains("VERSION:3.0"))
        XCTAssertTrue(vcf.contains("FN:John Doe"))
        XCTAssertTrue(vcf.contains("N:Doe;John;;;"))
        XCTAssertTrue(vcf.contains("TEL;TYPE=CELL:+33 612-345-678"))
        XCTAssertTrue(vcf.contains("EMAIL;TYPE=INTERNET:john.doe@example.com"))
        XCTAssertTrue(vcf.contains("ORG:Infomaniak"))
        XCTAssertTrue(vcf.contains("END:VCARD"))
    }

    func testVCardContainsLinks() {
        let vcf = ContactCard.sample.makeVCardString()

        XCTAssertTrue(vcf.contains("item1.URL:https://www.john.doe.com/"))
        XCTAssertTrue(vcf.contains("item1.X-ABLabel:Website"))
        XCTAssertTrue(vcf.contains("item2.URL:https://www.linkedin.com/john.doe"))
        XCTAssertTrue(vcf.contains("item2.X-ABLabel:LinkedIn"))
    }

    func testVCardNoPhotoWhenQRCodeMode() {
        let vcf = ContactCard.sample.makeVCardString(forQRCode: true)

        XCTAssertFalse(vcf.contains("PHOTO"), "The QR Code mode must not include a photo")
    }

    func testVCardNoLinksWhenNone() {
        let vcf = ContactCard.minimal.makeVCardString()

        XCTAssertFalse(vcf.contains("item1.URL"), "No links should appear if links is nil")
    }

    func testVCardEmptyLinksAreSkipped() {
        let card = ContactCard(
            id: 2,
            firstName: "A",
            lastName: "B",
            email: "a@b.com",
            phone: "000",
            links: [
                ContactCardLink(type: .website, url: ""),
                ContactCardLink(type: .linkedIn, url: "https://linkedin.com/ab")
            ]
        )
        let vcf = card.makeVCardString()

        XCTAssertFalse(vcf.contains("item1.X-ABLabel:Website"), "An empty link should not appear")
        XCTAssertTrue(vcf.contains("item1.X-ABLabel:LinkedIn"))
    }

    func testVCardOptionalCompanyIsEmpty() {
        let vcf = ContactCard.minimal.makeVCardString()

        XCTAssertTrue(vcf.contains("ORG:"), "ORG must be included even without company")
        XCTAssertFalse(vcf.contains("ORG:Infomaniak"))
    }

    // MARK: - Codable

    func testContactCardEncodeDecode() throws {
        let encoded = try JSONEncoder().encode(ContactCard.sample)
        let decoded = try JSONDecoder().decode(ContactCard.self, from: encoded)

        XCTAssertEqual(decoded.id, ContactCard.sample.id)
        XCTAssertEqual(decoded.firstName, ContactCard.sample.firstName)
        XCTAssertEqual(decoded.lastName, ContactCard.sample.lastName)
        XCTAssertEqual(decoded.email, ContactCard.sample.email)
        XCTAssertEqual(decoded.phone, ContactCard.sample.phone)
        XCTAssertEqual(decoded.company, ContactCard.sample.company)
        XCTAssertEqual(decoded.links?.count, ContactCard.sample.links?.count)
    }

    func testContactCardDecodeInvalidDataThrows() {
        let invalidData = Data("not json".utf8)
        XCTAssertThrowsError(try JSONDecoder().decode(ContactCard.self, from: invalidData))
    }

    // MARK: - Hashable / Equatable

    func testContactCardHashableEquality() {
        let card1 = ContactCard.sample
        let card2 = ContactCard.sample
        XCTAssertEqual(card1, card2)
        XCTAssertEqual(card1.hashValue, card2.hashValue)
    }

    func testContactCardInequalityOnDifferentId() {
        let card1 = ContactCard.sample
        let card2 = ContactCard(
            id: 99,
            firstName: "John",
            lastName: "Doe",
            email: "john.doe@example.com",
            phone: "+33 612-345-678"
        )
        XCTAssertNotEqual(card1, card2)
    }
}
