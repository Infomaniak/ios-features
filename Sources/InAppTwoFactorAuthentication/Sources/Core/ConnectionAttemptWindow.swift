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
