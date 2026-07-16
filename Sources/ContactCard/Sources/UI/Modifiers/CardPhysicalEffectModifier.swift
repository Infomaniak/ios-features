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
import CoreMotion
import Observation
import SwiftUI

@available(iOS 17.0, *)
@Observable
final class CardMotionManager {
    private(set) var roll: Double = 0
    private(set) var pitch: Double = 0

    private let motionManager = CMMotionManager()

    func start() {
        guard motionManager.isDeviceMotionAvailable else { return }
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
        motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { [weak self] motion, _ in
            guard let motion else { return }
            self?.roll = motion.attitude.roll
            self?.pitch = motion.attitude.pitch
        }
    }

    func stop() {
        motionManager.stopDeviceMotionUpdates()
    }
}

@available(iOS 17.0, *)
struct CardPhysicalEffectModifier: ViewModifier {
    @Environment(\.scenePhase) private var scenePhase

    @State private var motion = CardMotionManager()

    static private let maxRotationAngle: Double = .pi / 6

    private var roll: Double {
        return clamp(motion.roll, min: -Self.maxRotationAngle, max: Self.maxRotationAngle)
    }

    private var pitch: Double {
        return clamp(motion.pitch, min: -Self.maxRotationAngle, max: Self.maxRotationAngle)
    }

    func body(content: Content) -> some View {
        content
            .visualEffect { view, proxy in
                view.layerEffect(
                    ShaderLibrary.bundle(.module).cardSpecular(
                        .float2(proxy.size),
                        .float2(CGFloat(roll), CGFloat(pitch)),
                        .float(0.8),
                        .float(18.0)
                    ),
                    maxSampleOffset: .zero
                )
            }
            .rotation3DEffect(
                .radians(pitch),
                axis: (x: 1, y: 0, z: 0),
                anchor: .center,
                perspective: 0.5
            )
            .rotation3DEffect(
                .radians(roll),
                axis: (x: 0, y: 1, z: 0),
                anchor: .center,
                perspective: 0.5
            )
            .onAppear { motion.start() }
            .onDisappear { motion.stop() }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    motion.start()
                } else {
                    motion.stop()
                }
            }
    }

    private func clamp(_ value: Double, min minValue: Double, max maxValue: Double) -> Double {
        return min(max(value, -minValue), maxValue)
    }
}

extension View {
    func cardPhysicalEffect() -> some View {
        if #available(iOS 17.0, *) {
            return modifier(CardPhysicalEffectModifier())
        } else {
            return self
        }
    }
}
#endif
