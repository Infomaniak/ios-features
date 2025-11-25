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
            .modifier(IKButtonExpandableModifier())
            .contentShape(Rectangle())
            .modifier(IKButtonOpacityAnimationModifier(isPressed: configuration.isPressed))
            .allowsHitTesting(!isLoading)
            .background(
                RoundedRectangle(cornerRadius: IKRadius.large)
                    .stroke(Color.Custom.divider, lineWidth: 0.5)
            )
    }
}

#Preview {
    VStack {
        Button("Hello, World!") {}

        Button("Hello, World!") {}
            .ikButtonFullWidth(true)
    }
    .buttonStyle(.outlined)
}
