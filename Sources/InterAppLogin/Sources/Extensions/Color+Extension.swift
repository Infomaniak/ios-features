/*
 iOS Features
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

import SwiftUI

extension Color {
    enum Custom {
        /// light: greyOrca / dark: greyRabbit
        public static let textPrimary = Color(
            light: UIColor.greyOrca,
            dark: UIColor.greyRabbit
        )
        /// light: greyElephant / dark: greyShark
        public static let textSecondary = Color(
            light: UIColor.greyElephant,
            dark: UIColor.greyShark
        )

        /// light: greyMouse / dark: greyOrca
        public static let divider = Color(
            light: UIColor.greyMouse,
            dark: UIColor.greyOrca
        )
    }
}
