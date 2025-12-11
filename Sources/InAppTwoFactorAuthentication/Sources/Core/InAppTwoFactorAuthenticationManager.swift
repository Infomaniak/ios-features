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

import Foundation
import InfomaniakCore
import UIKit

public protocol InAppTwoFactorAuthenticationManagerable {
    func checkConnectionAttempts(using sessions: [InAppTwoFactorAuthenticationSession])
    func checkConnectionAttempts(using session: InAppTwoFactorAuthenticationSession)
    func handleRemoteNotification(_ notification: UNNotification) -> InAppTwoFactorAuthenticationManager.UserId?
}

public final class InAppTwoFactorAuthenticationManager: InAppTwoFactorAuthenticationManagerable {
    public typealias UserId = Int

    private weak var lastActiveScene: UIWindowScene?

    private var currentAttemptUUID: String?
    private var currentWindow: UIWindow?

    private let checkIntervalSeconds: TimeInterval
    private var lastCheckedConnectionAttemptsDate: Date?

    private typealias CheckConnectionAttemptResult = (session: InAppTwoFactorAuthenticationSession, challenge: RemoteChallenge)

    public init(checkIntervalSeconds: TimeInterval = 30) {
        self.checkIntervalSeconds = checkIntervalSeconds
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotification(_:)),
            name: UIScene.didActivateNotification,
            object: nil
        )
    }

    @objc private func handleNotification(_ notification: Notification) {
        guard let scene = notification.object as? UIWindowScene,
              scene.session.role == .windowApplication else { return }
        lastActiveScene = scene
    }

    public func checkConnectionAttempts(using sessions: [InAppTwoFactorAuthenticationSession]) {
        guard !sessions.isEmpty,
              Date().timeIntervalSince(lastCheckedConnectionAttemptsDate ?? .distantPast) > checkIntervalSeconds else {
            return
        }

        lastCheckedConnectionAttemptsDate = Date()

        Task {
            await withTaskGroup(of: CheckConnectionAttemptResult?.self) { group in
                for session in sessions {
                    group.addTask {
                        return await self.checkConnectionAttemptWith(session: session)
                    }
                }

                for await completeSession in group {
                    guard let completeSession else { continue }

                    await displayConnectionAttemptWindowFor(completeSession: completeSession)

                    return
                }
            }
        }
    }

    public func checkConnectionAttempts(using session: InAppTwoFactorAuthenticationSession) {
        Task {
            guard let completeSession = await checkConnectionAttemptWith(session: session) else {
                return
            }

            await displayConnectionAttemptWindowFor(completeSession: completeSession)
        }
    }

    public func handleRemoteNotification(_ notification: UNNotification) -> UserId? {
        guard let userInfo = notification.request.content.userInfo as? [String: Any],
              let type = userInfo[NotificationUserInfoKeys.type] as? String,
              type == NotificationType.challengeApproval,
              let userId = userInfo[NotificationUserInfoKeys.userId] as? Int
        else {
            return nil
        }

        return userId
    }

    private func checkConnectionAttemptWith(session: InAppTwoFactorAuthenticationSession) async -> CheckConnectionAttemptResult? {
        do {
            guard let attempt = try await session.apiFetcher.latestChallenge() else {
                return nil
            }

            guard attempt.type == .approval else {
                return nil // Only approval challenges are currently supported
            }

            return (session: session, challenge: attempt)
        } catch {
            return nil
        }
    }

    @MainActor
    private func displayConnectionAttemptWindowFor(completeSession: CheckConnectionAttemptResult) {
        if let existingRootViewController = currentWindow?.rootViewController {
            guard currentAttemptUUID != completeSession.challenge.uuid else {
                return
            }

            existingRootViewController.dismiss(animated: true) { [weak self] in
                self?.currentAttemptUUID = completeSession.challenge.uuid
                self?.currentWindow = ConnectionAttemptWindow(
                    session: completeSession.session,
                    connectionAttempt: completeSession.challenge,
                    windowScene: self?.lastActiveScene
                ) { [weak self] in
                    self?.currentWindow?.resignKey()
                    self?.currentAttemptUUID = nil
                    self?.currentWindow = nil
                }
            }
        } else {
            currentAttemptUUID = completeSession.challenge.uuid
            currentWindow = ConnectionAttemptWindow(
                session: completeSession.session,
                connectionAttempt: completeSession.challenge,
                windowScene: lastActiveScene
            ) { [weak self] in
                self?.currentWindow?.resignKey()
                self?.currentAttemptUUID = nil
                self?.currentWindow = nil
            }
        }
    }
}
