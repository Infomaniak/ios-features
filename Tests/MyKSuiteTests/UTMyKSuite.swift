//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.

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
