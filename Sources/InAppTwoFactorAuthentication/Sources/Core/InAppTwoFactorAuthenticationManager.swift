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

import Foundation
import InfomaniakCore
import UIKit

public protocol InAppTwoFactorAuthenticationManagerable {
    func checkConnectionAttempts(using sessions: [InAppTwoFactorAuthenticationSession])
}

public final class InAppTwoFactorAuthenticationManager: InAppTwoFactorAuthenticationManagerable {
    private weak var lastActiveScene: UIWindowScene?
    private var currentWindow: UIWindow?
    private typealias CheckConnectionAttemptResult = (session: InAppTwoFactorAuthenticationSession, attempt: ConnectionAttempt)

    public init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotification(_:)),
            name: UIScene.didActivateNotification,
            object: nil
        )
    }

    @objc private func handleNotification(_ notification: Notification) {
        guard let scene = notification.object as? UIWindowScene else { return }
        lastActiveScene = scene
    }

    public func checkConnectionAttempts(using sessions: [InAppTwoFactorAuthenticationSession]) {
        guard !sessions.isEmpty else { return }

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

    private func checkConnectionAttemptWith(session: InAppTwoFactorAuthenticationSession) async -> CheckConnectionAttemptResult? {
        do {
            let attempt = try await session.apiFetcher.latestConnectionAttempt()
            return (session: session, attempt: attempt)
        } catch {
            return nil
        }
    }

    @MainActor
    private func displayConnectionAttemptWindowFor(completeSession: CheckConnectionAttemptResult) {
        currentWindow = ConnectionAttemptWindow(
            session: completeSession.session,
            connectionAttempt: completeSession.attempt,
            windowScene: lastActiveScene
        )
    }
}
