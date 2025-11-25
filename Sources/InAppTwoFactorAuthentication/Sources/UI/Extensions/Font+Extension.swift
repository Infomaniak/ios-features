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

import SwiftUI

extension Font {
    enum Custom {
        /// Figma name: *Titre H2*
        static let title2 = Font.dynamicTypeSizeFont(size: 18, weight: .semibold, relativeTo: .title2)

        /// Figma name: *Body Medium*
        static let headline = Font.dynamicTypeSizeFont(size: 16, weight: .medium, relativeTo: .headline)

        /// Figma name: *Body Regular*
        static let body = Font.dynamicTypeSizeFont(size: 16, weight: .regular, relativeTo: .body)

        /// Figma name: *Body Small Regular*
        static let callout = Font.dynamicTypeSizeFont(size: 14, weight: .regular, relativeTo: .callout)
    }
}
