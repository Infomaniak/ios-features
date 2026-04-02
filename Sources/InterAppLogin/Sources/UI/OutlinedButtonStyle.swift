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

import DesignSystem
import Foundation
import InfomaniakCoreSwiftUI
import SwiftUI

public extension EnvironmentValues {
    var outlinedButtonBackgroundColor: Color {
        get {
            self[OutlinedButtonBackgroundKey.self]
        }
        set {
            self[OutlinedButtonBackgroundKey.self] = newValue
        }
    }

    private struct OutlinedButtonBackgroundKey: EnvironmentKey {
        static let defaultValue = Color.Surface.tertiarySystemBackground
    }
}

extension ButtonStyle where Self == OutlinedButtonStyle {
    static var outlined: OutlinedButtonStyle {
        return OutlinedButtonStyle()
    }
}

struct OutlinedButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.ikButtonTheme) private var theme
    @Environment(\.ikButtonLoading) private var isLoading
    @Environment(\.outlinedButtonBackgroundColor) private var backgroundColor

    private var foreground: Color {
        if isEnabled {
            return .Custom.textPrimary
        } else {
            return .Custom.textSecondary
        }
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .labelStyle(.ikLabel)
            .foregroundStyle(foreground)
            .modifier(IKButtonLoadingModifier(isFilled: false))
            .modifier(IKButtonControlSizeModifier())
            .padding(.horizontal, value: .medium)
            .padding(.horizontal, value: .small)
            .frame(minHeight: IKButtonHeight.large)
            .modifier(IKButtonExpandableModifier())
            .contentShape(Rectangle())
            .modifier(IKButtonOpacityAnimationModifier(isPressed: configuration.isPressed))
            .allowsHitTesting(!isLoading)
            .background(backgroundColor, in: RoundedRectangle(cornerRadius: theme.cornerRadius))
            .background(
                RoundedRectangle(cornerRadius: theme.cornerRadius)
                    .stroke(Color.Custom.divider, lineWidth: 0.5)
            )
    }
}

#Preview {
    VStack {
        Button("Hello, World!") {}

        Button("Hello, World!") {}
            .ikButtonFullWidth(true)

        Button("Hello, World!") {}
            .environment(\.outlinedButtonBackgroundColor, .red)
    }
    .buttonStyle(.outlined)
}
