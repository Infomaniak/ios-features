/*
 Infomaniak Features - iOS
 Copyright (C) 2026 Infomaniak Network SA

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

import InfomaniakCoreSwiftUI
import LocalAuthentication
import SwiftUI
import UIKit

public struct AppLockUIConfiguration {
    private static let onboardingLogoHeight: CGFloat = 56

    let logoView: () -> AnyView
    let lockImage: Image
    let lockImageSize: CGFloat
    let ikButtonTheme: IKButtonTheme

    public init(logoImage: Image, lockImage: Image, lockImageSize: CGFloat = 187, ikButtonTheme: IKButtonTheme) {
        logoView = {
            AnyView(
                logoImage
                    .resizable()
                    .scaledToFit()
                    .frame(height: Self.onboardingLogoHeight)
                    .accessibilityHidden(true)
            )
        }
        self.lockImage = lockImage
        self.lockImageSize = lockImageSize
        self.ikButtonTheme = ikButtonTheme
    }

    public init(
        @ViewBuilder logoView: @escaping () -> AnyView,
        lockImage: Image,
        lockImageSize: CGFloat = 187,
        ikButtonTheme: IKButtonTheme
    ) {
        self.logoView = logoView
        self.lockImage = lockImage
        self.lockImageSize = lockImageSize
        self.ikButtonTheme = ikButtonTheme
    }
}

public final class AppLockHelper {
    public static let lockAfterOneMinute: TimeInterval = 60

    let appLockUIConfiguration: AppLockUIConfiguration
    let userDefaults: UserDefaults
    private var deviceHasBeenLocked = false
    private var isAuthenticating = false
    private let intervalToLockApp: TimeInterval
    private var timeSinceAppEnteredBackground = TimeInterval.zero

    private var currentWindow: UIWindow?
    private weak var lastActiveScene: UIWindowScene?

    public var isAppLocked: Bool {
        let timeHasExpired = timeSinceAppEnteredBackground + intervalToLockApp < Date().timeIntervalSince1970
        return userDefaults.isAppLockEnabled && isAvailable() && (timeHasExpired || deviceHasBeenLocked)
    }

    public init(
        intervalToLockApp: TimeInterval = AppLockHelper.lockAfterOneMinute,
        appLockUIConfiguration: AppLockUIConfiguration,
        userDefaults: UserDefaults = UserDefaults.standard
    ) {
        self.intervalToLockApp = intervalToLockApp
        self.appLockUIConfiguration = appLockUIConfiguration
        self.userDefaults = userDefaults
    }

    public func isAvailable(_ context: LAContext? = nil) -> Bool {
        let currentContext = context ?? LAContext()
        return currentContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
    }

    public func setTime() {
        timeSinceAppEnteredBackground = Date().timeIntervalSince1970
        deviceHasBeenLocked = false
    }

    public func evaluatePolicy(reason: String) async throws -> Bool {
        let context = LAContext()
        guard isAvailable(context) else {
            return false
        }

        isAuthenticating = true
        defer { isAuthenticating = false }

        let unlocked = try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason)

        if unlocked {
            setTime()
        }

        return unlocked
    }

    public func evaluatePolicyInAppLockExtension(reason: String) async -> Bool {
        guard userDefaults.isAppLockEnabled && isAppLocked else {
            return true
        }

        let unlocked = await (try? evaluatePolicy(reason: reason)) == true
        return unlocked
    }

    public func startObservation() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(deviceDidLock),
                                               name: UIApplication.willResignActiveNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleNotification(_:)),
                                               name: UIScene.didActivateNotification,
                                               object: nil)
    }

    @objc private func deviceDidLock() {
        guard !isAuthenticating else { return }
        deviceHasBeenLocked = true
    }

    @objc private func handleNotification(_ notification: Notification) {
        guard let scene = notification.object as? UIWindowScene, scene.session.role == .windowApplication else {
            return
        }
        lastActiveScene = scene
        if isAppLocked {
            Task { @MainActor in
                displayAppLockAttemptWindowFor()
            }
        }
    }

    @MainActor
    private func displayAppLockAttemptWindowFor() {
        guard currentWindow == nil else { return }
        currentWindow = AppLockAttemptWindow(
            appLockUIConfiguration: appLockUIConfiguration,
            windowScene: lastActiveScene
        ) { [weak self] in
            self?.currentWindow?.resignKey()
            self?.currentWindow = nil
        }
    }
}
