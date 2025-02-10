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

import DesignSystem
import SwiftUI

struct CardModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme

    let withStroke: Bool

    private var strokeOpacity: Double {
        if withStroke {
            return colorScheme == .light ? 0 : 1
        }
        return 0
    }

    private var shadowOpacity: Double {
        colorScheme == .light ? 0.3 : 0
    }

    func body(content: Content) -> some View {
        content
            .clipShape(.rect(cornerRadius: IKRadius.large))
            .overlay {
                RoundedRectangle(cornerRadius: IKRadius.large)
                    .strokeBorder(Resources.Colors.elephant.swiftUIColor.opacity(strokeOpacity), lineWidth: 1)
            }
            .shadow(color: Resources.Colors.shark.swiftUIColor.opacity(shadowOpacity), radius: 10)
    }
}

extension View {
    func cardStyle(withStroke: Bool = true) -> some View {
        modifier(CardModifier(withStroke: withStroke))
    }
}
