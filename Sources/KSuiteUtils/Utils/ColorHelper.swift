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
