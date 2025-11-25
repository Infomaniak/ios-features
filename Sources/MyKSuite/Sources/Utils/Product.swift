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

import KSuiteUtils
import SwiftUI

enum Product {
    case mail
    case drive

    var title: String {
        switch self {
        case .mail:
            return "Mail"
        case .drive:
            return "kDrive"
        }
    }

    var color: Color {
        switch self {
        case .mail:
            return KSuiteUtilsResources.productMail.swiftUIColor
        case .drive:
            return KSuiteUtilsResources.productDrive.swiftUIColor
        }
    }
}
