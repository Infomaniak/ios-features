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

import LocalAuthentication
import SwiftUI
import UIKit

public final class AppLockHelper {
    public static let lockAfterOneMinute: TimeInterval = 60

    let logoImage: Image
    let lockImage: Image
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
        logoImage: Image,
        lockImage: Image,
        userDefaults: UserDefaults = UserDefaults.standard
    ) {
        self.intervalToLockApp = intervalToLockApp
        self.lockImage = lockImage
        self.logoImage = logoImage
        self.userDefaults = userDefaults
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(deviceDidLock),
                                               name: UIApplication.willResignActiveNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleNotification(_:)),
                                               name: UIScene.didActivateNotification,
                                               object: nil)
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

        return try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason)
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
        if let existingRootViewController = currentWindow?.rootViewController {
            existingRootViewController.dismiss(animated: true) { [weak self] in
                guard let self else { return }
                currentWindow = AppLockAttemptWindow(
                    lockImage: lockImage, logoImage: logoImage,
                    windowScene: lastActiveScene
                ) { [weak self] in
                    self?.currentWindow?.resignKey()
                    self?.currentWindow = nil
                }
            }
        } else {
            currentWindow = AppLockAttemptWindow(
                lockImage: lockImage, logoImage: logoImage,
                windowScene: lastActiveScene
            ) { [weak self] in
                self?.currentWindow?.resignKey()
                self?.currentWindow = nil
            }
        }
    }
}
