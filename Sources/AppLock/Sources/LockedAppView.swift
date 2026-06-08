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

import DesignSystem
import InfomaniakCoreCommonUI
import InfomaniakCoreSwiftUI
import InfomaniakCoreUIResources
import InfomaniakDI
import SwiftUI

struct LockedAppView<LogoView: View>: View {
    @Environment(\.dismiss) private var dismiss

    let appLockUIConfiguration: AppLockUIConfiguration<LogoView>

    @State private var isEvaluatingPolicy = false

    var body: some View {
        ZStack {
            VStack(spacing: IKPadding.large) {
                appLockUIConfiguration.lockImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: appLockUIConfiguration.lockImageSize, height: appLockUIConfiguration.lockImageSize)

                Text(Localizable.lockAppTitle)
                    .font(Font(TextStyle.header2.font))
                    .foregroundColor(Color(TextStyle.header2.color))
            }
            VStack {
                VStack {
                    appLockUIConfiguration.logoView()
                }
                .frame(maxHeight: .infinity, alignment: .topLeading)

                Button(Localizable.buttonUnlock, action: unlockApp)
                    .buttonStyle(.ikBorderedProminent)
                    .controlSize(.large)
                    .ikButtonFullWidth(true)
                    .ikButtonLoading(isEvaluatingPolicy)
                    .ikButtonTheme(appLockUIConfiguration.ikButtonTheme)
            }
            .padding(.top, IKPadding.large)
            .padding(.bottom, value: .giant)
        }
        .padding(.horizontal, value: .large)
        .onAppear {
            unlockApp()
        }
        .matomoView(view: ["LockedAppView"])
    }

    private func unlockApp() {
        @LazyInjectService var appLockHelper: AppLockHelping
        guard !isEvaluatingPolicy else { return }

        Task { @MainActor in
            isEvaluatingPolicy = true
            if await (try? appLockHelper.evaluatePolicy(reason: Localizable.lockAppTitle)) == true {
                appLockHelper.setTime()
                dismiss()
            } else {
                isEvaluatingPolicy = false
            }
        }
    }
}

#Preview {
    LockedAppView(appLockUIConfiguration: AppLockUIConfiguration(
        logoImage: Image(systemName: "lock"),
        lockImage: Image(systemName: "plane"),
        lockImageSize: 187,
        ikButtonTheme: .init(
            primary: .red,
            secondary: .blue,
            tertiary: .green,
            disabledPrimary: .yellow,
            disabledSecondary: .purple,
            error: .background,
            smallFont: .callout,
            mediumFont: .body
        )
    ))
}
