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
import Foundation
import InfomaniakCoreSwiftUI
import SwiftUI

extension ButtonStyle where Self == OutlinedButtonStyle {
    static var outlined: OutlinedButtonStyle {
        return OutlinedButtonStyle()
    }
}

struct OutlinedButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    @Environment(\.ikButtonLoading) private var isLoading

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
            .contentShape(Rectangle())
            .modifier(IKButtonOpacityAnimationModifier(isPressed: configuration.isPressed))
            .allowsHitTesting(!isLoading)
            .background(
                RoundedRectangle(cornerRadius: IKRadius.large)
                    .stroke(Color.Custom.divider, lineWidth: 0.5)
            )
    }
}
