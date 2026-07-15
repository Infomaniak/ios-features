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

@available(iOS 16.4, *)
struct Card3DEffectIfAvailableModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            content
                .modifier(Card3DEffectModifier())
        } else {
            content
        }
    }
}

@available(iOS 17.0, *)
private struct Card3DEffectModifier: ViewModifier {
    @State private var motionManager = CardMotionManager()

    private let rotationMultiplier: Double = 12

    private var specularShader: Shader {
        ShaderLibrary.default.specularHighlight(
            .boundingRect,
            .float2(Float(motionManager.tiltX), Float(motionManager.tiltY))
        )
    }

    func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                .degrees(motionManager.tiltY * rotationMultiplier),
                axis: (x: 1, y: 0, z: 0),
                perspective: 0.3
            )
            .rotation3DEffect(
                .degrees(-motionManager.tiltX * rotationMultiplier),
                axis: (x: 0, y: 1, z: 0),
                perspective: 0.3
            )
            .layerEffect(specularShader, maxSampleOffset: .zero)
    }
}

@available(iOS 16.4, *)
extension View {
    func card3DEffect() -> some View {
        modifier(Card3DEffectIfAvailableModifier())
    }
}
