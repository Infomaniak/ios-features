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

import SwiftUI

extension Color {
    enum Custom {
        /// light: greyOrca / dark: greyRabbit
        static let textPrimary = Color(
            light: UIColor.greyOrca,
            dark: UIColor.greyRabbit
        )
        /// light: greyElephant / dark: greyShark
        static let textSecondary = Color(
            light: UIColor.greyElephant,
            dark: UIColor.greyShark
        )

        /// light: greyMouse / dark: greyOrca
        static let divider = Color(
            light: UIColor.greyMouse,
            dark: UIColor.greyOrca
        )
    }
}
