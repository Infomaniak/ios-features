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

#if canImport(UIKit)
import SwiftUI

public struct ContactCardTheme {
    let primary: Color
    let secondary: Color
    let primaryText: Color
    let secondaryText: Color
    let onAccent: Color
    let background: Color
    let backgroundTint: Color
    let navBarBackground: Color
    let snackbarActionColor: Color
    let onBoardingImage: Image

    public init(
        primary: Color,
        secondary: Color,
        primaryText: Color,
        secondaryText: Color,
        onAccent: Color,
        background: Color,
        backgroundTint: Color,
        navBarBackground: Color,
        snackbarActionColor: Color,
        onBoardingImage: Image
    ) {
        self.primary = primary
        self.secondary = secondary
        self.primaryText = primaryText
        self.secondaryText = secondaryText
        self.onAccent = onAccent
        self.background = background
        self.backgroundTint = backgroundTint
        self.navBarBackground = navBarBackground
        self.snackbarActionColor = snackbarActionColor
        self.onBoardingImage = onBoardingImage
    }

    static let pink = ContactCardTheme(
        primary: Color(red: 0.81, green: 0.12, blue: 0.39),
        secondary: Color(red: 0.96, green: 0.73, blue: 0.85),
        primaryText: Color(.black),
        secondaryText: Color(.darkGray),
        onAccent: Color.white,
        background: .white,
        backgroundTint: Color(.systemGray6),
        navBarBackground: Color(red: 0.20, green: 0.04, blue: 0.11),
        snackbarActionColor: Color(red: 0.96, green: 0.73, blue: 0.85),
        onBoardingImage: Image(systemName: "cube.fill")
    )
}

private struct ContactCardThemeKey: EnvironmentKey {
    static let defaultValue: ContactCardTheme = .pink
}

public extension EnvironmentValues {
    var contactCardTheme: ContactCardTheme {
        get { self[ContactCardThemeKey.self] }
        set { self[ContactCardThemeKey.self] = newValue }
    }
}
#endif
