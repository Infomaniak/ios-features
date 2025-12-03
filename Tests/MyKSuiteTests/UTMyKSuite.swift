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
import MyKSuite
import XCTest

final class UTMyKSuite: XCTestCase {
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }

    func testKSuiteFreeLocalObjectDecoding() {
        // GIVEN
        let rawJSON = """
        {
          "id": 1,
          "status": "healthy",
          "pack_id": 1,
          "trial_expiry_at": null,
          "is_free": true,
          "drive": {
            "id": 1,
            "name": "Name",
            "size": 16106127360,
            "used_size": 102253412
          },
          "mail": {
            "id": 1,
            "daily_limit_sent": 500,
            "storage_size_limit": 21474836480,
            "email": "address@ik.me",
            "mailbox_id": 1,
            "used_size": 0
          }
        }
        """

        // WHEN
        let myKSuite = try? decoder.decode(MyKSuite.self, from: rawJSON.data(using: .utf8)!)

        // THEN
        XCTAssertNotNil(myKSuite)
    }

    func testKSuitePlusLocalObjectDecoding() {
        // GIVEN
        let rawJSON = """
        {
          "id": 1,
          "status": "healthy",
          "pack_id": 1,
          "trial_expiry_at": 1769814000,
          "is_free": false,
          "drive": {
            "id": 1,
            "name": "Name",
            "size": 16106127360,
            "used_size": 102253412
          },
          "mail": {
            "id": 1,
            "daily_limit_sent": 500,
            "storage_size_limit": 21474836480,
            "email": "address@ik.me",
            "mailbox_id": 1,
            "used_size": 0
          }
        }
        """

        // WHEN
        let myKSuite = try? decoder.decode(MyKSuite.self, from: rawJSON.data(using: .utf8)!)

        // THEN
        XCTAssertNotNil(myKSuite)
    }
}
