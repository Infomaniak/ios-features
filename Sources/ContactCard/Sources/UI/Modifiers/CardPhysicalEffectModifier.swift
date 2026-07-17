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
    private(set) var roll = 0.0
    private(set) var pitch = 0.0

    private var initialRoll: Double?
    private var initialPitch: Double?

    private let motionManager = CMMotionManager()

    deinit {
        stop()
    }

    func start() {
        guard motionManager.isDeviceMotionAvailable else {
            return
        }

        initialRoll = nil
        initialPitch = nil

        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
        motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { [weak self] motion, _ in
            guard let self, let motion else { return }

            let attitude = motion.attitude
            if initialRoll == nil || initialPitch == nil {
                initialRoll = attitude.roll
                initialPitch = attitude.pitch
            }

            roll = Self.normalizedAngleDelta(from: initialRoll ?? attitude.roll, to: attitude.roll)
            pitch = Self.normalizedAngleDelta(from: initialPitch ?? attitude.pitch, to: attitude.pitch)
        }
    }

    func stop() {
        motionManager.stopDeviceMotionUpdates()
    }

    private static func normalizedAngleDelta(from initialAngle: Double, to currentAngle: Double) -> Double {
        let delta = currentAngle - initialAngle
        return atan2(sin(delta), cos(delta))
    }
}

@available(iOS 17.0, *)
struct CardPhysicalEffectModifier: ViewModifier {
    @State private var motion = CardMotionManager()

    private nonisolated static let lightIntensity = 0.25
    private nonisolated static let lightSpecPower = 6.0

    private nonisolated static let maxRotationAngle = Double.pi / 12
    private nonisolated static let rotationPerspective = 0.2

    private var roll: Double {
        return clamp(motion.roll, min: -Self.maxRotationAngle, max: Self.maxRotationAngle)
    }

    private var pitch: Double {
        return clamp(motion.pitch, min: -Self.maxRotationAngle, max: Self.maxRotationAngle)
    }

    func body(content: Content) -> some View {
        let roll = roll
        let pitch = pitch

        ZStack {
            content

            Rectangle()
                .fill(.background)
                .opacity(0.1)
                .visualEffect { view, proxy in
                    view
                        .layerEffect(
                            ShaderLibrary.bundle(.module).cardSpecular(
                                .float2(proxy.size),
                                .float2(CGFloat(roll), CGFloat(pitch)),
                                .float(Self.lightIntensity),
                                .float(Self.lightSpecPower)
                            ),
                            maxSampleOffset: .zero
                        )
                }
        }
        .visualEffect { view, proxy in
            view
                .rotation3DEffect(
                    .radians(pitch),
                    axis: (x: 1, y: 0, z: 0),
                    anchor: .center,
                    perspective: Self.rotationPerspective
                )
                .rotation3DEffect(
                    .radians(roll),
                    axis: (x: 0, y: 1, z: 0),
                    anchor: .center,
                    perspective: Self.rotationPerspective
                )
        }

        .onAppear {
            motion.start()
        }
    }

    private func clamp(_ value: Double, min minValue: Double, max maxValue: Double) -> Double {
        return min(max(value, minValue), maxValue)
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
