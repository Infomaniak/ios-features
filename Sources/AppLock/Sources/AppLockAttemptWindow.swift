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

import Foundation
import SwiftUI
import UIKit

class AppLockViewHostingViewController: UIHostingController<LockedAppView> {
    var onDisappear: (() -> Void)?

    init(appLockUIConfiguration: AppLockUIConfiguration) {
        super.init(rootView: LockedAppView(appLockUIConfiguration: appLockUIConfiguration))
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

class AppLockAttemptWindow: UIWindow {
    let hostingViewController: AppLockViewHostingViewController

    init(
        appLockUIConfiguration: AppLockUIConfiguration,
        windowScene: UIWindowScene?,
        onDisappear: @escaping (() -> Void)
    ) {
        hostingViewController = AppLockViewHostingViewController(
            appLockUIConfiguration: appLockUIConfiguration
        )
        if let windowScene {
            super.init(windowScene: windowScene)
        } else {
            super.init(frame: UIScreen.main.bounds)
        }

        let emptyRootViewController = UIViewController()
        rootViewController = emptyRootViewController
        Task { @MainActor in
            hostingViewController.modalPresentationStyle = .fullScreen
            emptyRootViewController.present(hostingViewController, animated: true)
        }
        windowLevel = .alert + 1
        makeKeyAndVisible()

        hostingViewController.onDisappear = onDisappear
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
