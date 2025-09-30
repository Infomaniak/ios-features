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

import DesignSystem
import InfomaniakCoreSwiftUI
import SwiftUI

extension DeviceType {
    var icon: Image {
        switch self {
        case .computer:
            Image(systemName: "laptopcomputer")
        case .phone:
            Image(systemName: "iphone.gen2")
        case .tablet:
            Image(systemName: "ipad.gen2")
        }
    }
}

extension Device {
    var description: String {
        guard let model else { return "\(platform)" }

        return "\(platform), \(model)"
    }
}

extension IKButtonTheme {
    static let feature = IKButtonTheme(
        primary: Color.featurePrimary,
        secondary: .white,
        tertiary: Color.featurePrimary.opacity(0.2),
        disabledPrimary: Color.gray,
        disabledSecondary: Color.gray.opacity(0.2),
        error: Color.red,
        smallFont: .Custom.headline,
        mediumFont: .Custom.headline
    )
}

enum ConnectionConfirmationContent {
    case main
    case error
    case connectionRefused

    var title: String {
        switch self {
        case .main:
            "!Are you sure you trying to sign in?"
        case .error:
            "!An error occurred"
        case .connectionRefused:
            "!Connection refused"
        }
    }
}

struct ConnectionConfirmationView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var currentContent: ConnectionConfirmationContent = .main

    let session: InAppTwoFactorAuthenticationSession
    let connectionConfirmationRequest: ConnectionAttempt

    init(session: InAppTwoFactorAuthenticationSession, connectionConfirmationRequest: ConnectionAttempt) {
        self.connectionConfirmationRequest = connectionConfirmationRequest
        self.session = session
    }

    init(
        session: InAppTwoFactorAuthenticationSession,
        connectionConfirmationRequest: ConnectionAttempt,
        currentContent: ConnectionConfirmationContent
    ) {
        self.currentContent = currentContent
        self.session = session
        self.connectionConfirmationRequest = connectionConfirmationRequest
    }

    var body: some View {
        NavigationView {
            FittingView { spaceConstrained in
                VStack(spacing: 0) {
                    VStack(spacing: IKPadding.medium) {
                        ZStack {
                            Circle()
                                .fill(Color.featurePrimary)
                                .frame(width: 48, height: 48)
                            Image(.shield)
                                .resizable()
                                .scaledToFit()
                                .frame(height: IKIconSize.large.rawValue)
                        }

                        Text(currentContent.title)
                            .font(.Custom.title2)
                            .foregroundStyle(Color.Custom.textPrimary)
                            .multilineTextAlignment(.center)
                    }

                    Group {
                        switch currentContent {
                        case .main:
                            MainContentView(session: session, connectionConfirmationRequest: connectionConfirmationRequest)
                                .padding(.top, value: spaceConstrained ? .small : .giant)
                        case .error:
                            InformationContentView(text: "!We couldn't process your request. Please try again later.")
                                .padding(.top, value: spaceConstrained ? .small : .large)
                        case .connectionRefused:
                            InformationContentView(
                                text: "!Connection refused.",
                                additionalAction: .init(title: "!Modify password") {}
                            )
                            .padding(.top, value: spaceConstrained ? .small : .large)
                        }
                    }
                    .frame(maxWidth: 600)
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.backgroundPrimary)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("!Close", systemImage: "xmark", role: .cancel, action: dismiss.callAsFunction)
                }
            }
        }
        .navigationViewStyle(.stack)
        .ikButtonTheme(.feature)
    }
}

#Preview("Main") {
    ConnectionConfirmationView(
        session: InAppTwoFactorAuthenticationSession(user: PreviewUser.preview,
                                                     apiFetcher: MockInAppTwoFactorAuthenticationFetcher()),
        connectionConfirmationRequest: .preview
    )
}

#Preview("Error") {
    ConnectionConfirmationView(
        session: InAppTwoFactorAuthenticationSession(user: PreviewUser.preview,
                                                     apiFetcher: MockInAppTwoFactorAuthenticationFetcher()),
        connectionConfirmationRequest: .preview,
        currentContent: .error
    )
}

#Preview("Connection refused") {
    ConnectionConfirmationView(
        session: InAppTwoFactorAuthenticationSession(user: PreviewUser.preview,
                                                     apiFetcher: MockInAppTwoFactorAuthenticationFetcher()),
        connectionConfirmationRequest: .preview,
        currentContent: .connectionRefused
    )
}
