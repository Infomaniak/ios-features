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
import SwiftUI
import UIKit

class ConnectionAttemptWindow: UIWindow {
    let hostingViewController: UIHostingController<ConnectionConfirmationView>

    init(session: InAppTwoFactorAuthenticationSession, connectionAttempt: ConnectionAttempt, windowScene: UIWindowScene?) {
        hostingViewController = UIHostingController(rootView: ConnectionConfirmationView(
            session: session,
            connectionConfirmationRequest: connectionAttempt
        ))

        if let windowScene {
            super.init(windowScene: windowScene)
        } else if let activeForegroundScene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            super.init(windowScene: activeForegroundScene)
        } else if let inactiveForegroundScene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundInactive }) as? UIWindowScene {
            super.init(windowScene: inactiveForegroundScene)
        } else {
            super.init(frame: UIScreen.main.bounds)
        }

        let emptyRootViewController = UIViewController()
        rootViewController = emptyRootViewController
        Task { @MainActor in
            emptyRootViewController.present(hostingViewController, animated: true)
        }

        windowLevel = .alert
        makeKeyAndVisible()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
