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

public enum ColorHelper {
    public static let backgroundPrimary = Color(light: .white, dark: KSuiteUtilsResources.bat.swiftUIColor)
    public static let backgroundSecondary = Color(
        light: KSuiteUtilsResources.polarBear.swiftUIColor,
        dark: KSuiteUtilsResources.orca.swiftUIColor
    )

    public static let chipBackground = Color(light: .white, dark: KSuiteUtilsResources.orca.swiftUIColor)

    public static let primary = Color(
        light: KSuiteUtilsResources.orca.swiftUIColor,
        dark: KSuiteUtilsResources.rabbit.swiftUIColor
    )
    public static let secondary = Color(
        light: KSuiteUtilsResources.elephant.swiftUIColor,
        dark: KSuiteUtilsResources.shark.swiftUIColor
    )

    public static let reversedPrimary = Color(
        light: KSuiteUtilsResources.rabbit.swiftUIColor,
        dark: KSuiteUtilsResources.orca.swiftUIColor
    )

    public static let divider = Color(
        light: KSuiteUtilsResources.mouse.swiftUIColor,
        dark: KSuiteUtilsResources.elephant.swiftUIColor
    )

    // MARK: - Gradient

    static let gradientColor1 = Color("gradient.color.1", bundle: .module)
    static let gradientColor2 = Color("gradient.color.2", bundle: .module)
    static let gradientColor3 = Color("gradient.color.3", bundle: .module)
    static let gradientColor4 = Color("gradient.color.4", bundle: .module)
    static let gradientColor5 = Color("gradient.color.5", bundle: .module)

    public static let gradient = LinearGradient(
        colors: [gradientColor1, gradientColor2, gradientColor3, gradientColor4, gradientColor5],
        startPoint: .leading,
        endPoint: .trailing
    )
}

extension Color {
    init(light: Color, dark: Color) {
        self.init(light: UIColor(light), dark: UIColor(dark))
    }

    private init(light: UIColor, dark: UIColor) {
        self.init(uiColor: UIColor { traits in
            switch traits.userInterfaceStyle {
            case .light, .unspecified:
                return light

            case .dark:
                return dark

            @unknown default:
                return light
            }
        })
    }
}
