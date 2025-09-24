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

class ConnectionConfirmationViewHostingViewController: UIHostingController<ConnectionConfirmationView> {
    var onDisappear: (() -> Void)?

    init(session: InAppTwoFactorAuthenticationSession, connectionAttempt: RemoteChallenge) {
        super.init(rootView: ConnectionConfirmationView(session: session, connectionConfirmationRequest: connectionAttempt))
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        onDisappear?()
    }
}

class ConnectionAttemptWindow: UIWindow {
    let hostingViewController: ConnectionConfirmationViewHostingViewController

    init(session: InAppTwoFactorAuthenticationSession,
         connectionAttempt: RemoteChallenge,
         windowScene: UIWindowScene?,
         onDisappear: @escaping (() -> Void)) {
        hostingViewController = ConnectionConfirmationViewHostingViewController(
            session: session,
            connectionAttempt: connectionAttempt
        )

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

        hostingViewController.onDisappear = onDisappear
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
