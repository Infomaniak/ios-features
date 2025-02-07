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

enum FontHelper {
    private static func dynamicTypeSizeFont(size: CGFloat, weight: Font.Weight, relativeTo textStyle: Font.TextStyle) -> Font {
        let fontFamily = UIFont.preferredFont(forTextStyle: .body).familyName
        return Font.custom(fontFamily, size: size, relativeTo: textStyle).weight(weight)
    }

    static let title: Font = dynamicTypeSizeFont(size: 18, weight: .semibold, relativeTo: .title2)

    // MARK: - Regular

    static let body: Font = dynamicTypeSizeFont(size: 16, weight: .regular, relativeTo: .body)
    static let bodySmall: Font = dynamicTypeSizeFont(size: 14, weight: .regular, relativeTo: .callout)

    // MARK: - Medium

    static let bodyMedium: Font = dynamicTypeSizeFont(size: 16, weight: .medium, relativeTo: .headline)

    static let bodySmallMedium: Font = dynamicTypeSizeFont(size: 14, weight: .medium, relativeTo: .callout)
    static let labelMedium: Font = dynamicTypeSizeFont(size: 12, weight: .medium, relativeTo: .caption)
}
