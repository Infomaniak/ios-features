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
    static let title: Font = .system(size: 18, weight: .semibold)

    // MARK: - Regular

    static let body: Font = .system(size: 16, weight: .regular)
    static let bodySmall: Font = .system(size: 14, weight: .regular)

    // MARK: - Medium

    static let bodyMedium: Font = .system(size: 16, weight: .medium)
    static let bodySmallMedium: Font = .system(size: 14, weight: .medium)
    static let labelMedium: Font = .system(size: 12, weight: .medium)
}
