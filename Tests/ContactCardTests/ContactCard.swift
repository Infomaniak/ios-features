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

final class ContactCardTest: XCTestCase {
    func testContactCardConvertToVCF() {
        let myLinks: [ContactCardLink] = [
            ContactCardLink(type: .website, url: "https://www.john.doe.com/"),
            ContactCardLink(type: .linkedIn, url: "https://www.linkedin.com/john.doe")
        ]
        let myTestProfil = ContactCard(
            id: 42,
            firstName: "John",
            lastName: "Doe",
            email: "john.doe@example.com",
            phone: "+33 612-345-678",
            company: "Infomaniak",
            links: myLinks
        )

        let vcf = myTestProfil.makeVCardString()

        print(vcf)

        XCTAssertTrue(vcf.contains("FN:John Doe"))
        XCTAssertTrue(vcf.contains("N:Doe;John;;;"))
        XCTAssertTrue(vcf.contains("TEL;TYPE=CELL:+33 612-345-678"))
        XCTAssertTrue(vcf.contains("EMAIL;TYPE=INTERNET:john.doe@example.com"))
        XCTAssertTrue(vcf.contains("item1.URL:https://www.john.doe.com/"))
        XCTAssertTrue(vcf.contains("item1.X-ABLabel:Website"))
        XCTAssertTrue(vcf.contains("item2.URL:https://www.linkedin.com/john.doe"))
        XCTAssertTrue(vcf.contains("item2.X-ABLabel:LinkedIn"))
        XCTAssertTrue(vcf.contains("item3.URL:"))
        XCTAssertTrue(vcf.contains("item3.X-ABLabel:Twitter"))
        XCTAssertTrue(vcf.contains("item4.URL:"))
        XCTAssertTrue(vcf.contains("item4.X-ABLabel:Facebook"))
        XCTAssertTrue(vcf.contains("END:VCARD"))
    }

    func testLoadIfNeedJsonToContactCard() async {
        let myLinks: [ContactCardLink] = [
            ContactCardLink(type: .website, url: "https://www.john.doe.com/"),
            ContactCardLink(type: .linkedIn, url: "https://www.linkedin.com/john.doe")
        ]

        let myTestProfil = ContactCard(
            id: 42,
            firstName: "John",
            lastName: "Doe",
            email: "john.doe@example.com",
            phone: "+33 612-345-678",
            company: "TestCorp",
            links: myLinks
        )

        let jsonData = await myTestProfil.save()
        XCTAssertFalse(jsonData.isEmpty, "Le JSON ne devrait pas être vide")

        let decoded = await myTestProfil.loadIfNeed(jsonData: jsonData)

        XCTAssertNotNil(decoded)
        XCTAssertEqual(decoded?.id, 42)
        XCTAssertEqual(decoded?.firstName, "John")
        XCTAssertEqual(decoded?.lastName, "Doe")
        XCTAssertEqual(decoded?.email, "john.doe@example.com")
        XCTAssertEqual(decoded?.phone, "+33 612-345-678")
        XCTAssertEqual(decoded?.company, "TestCorp")
        XCTAssertEqual(decoded?.links?.count, 2)
        XCTAssertEqual(decoded?.links?.first?.type, .website)
        XCTAssertEqual(decoded?.links?.first?.url, "https://www.john.doe.com/")

        let invalidJson = Data("not json".utf8)
        let failure = await myTestProfil.loadIfNeed(jsonData: invalidJson)
        XCTAssertNil(failure, "Un JSON invalide doit retourner nil")
    }
}
