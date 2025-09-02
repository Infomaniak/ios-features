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
import InfomaniakCore
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

struct ConnectionConfirmationView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var isLoading = false

    let session: InAppTwoFactorAuthenticationSession
    let connectionConfirmationRequest: ConnectionAttempt

    var body: some View {
        NavigationView {
            FittingView { spaceConstrained in
                VStack(spacing: spaceConstrained ? IKPadding.small : IKPadding.giant) {
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

                        Text("!Are you trying to sign in?")
                            .font(.Custom.title2)
                            .foregroundStyle(Color.Custom.textPrimary)
                            .multilineTextAlignment(.center)
                    }

                    ZStack {
                        Image(.backgroundLightSource)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: .infinity, alignment: .top)
                            .offset(y: -332 / 2 + 32)

                        VStack(alignment: .leading, spacing: IKPadding.medium) {
                            UserRowView(user: session.user)
                            Divider()

                            VStack {
                                VStack(spacing: IKPadding.medium) {
                                    RowView(title: "!When") {
                                        Text(connectionConfirmationRequest.requestDate, style: .relative)
                                    }

                                    RowView(title: "!Device") {
                                        HStack {
                                            Text(connectionConfirmationRequest.device.description)
                                            connectionConfirmationRequest.device.type.icon
                                        }
                                    }

                                    RowView(title: "!Location", description: connectionConfirmationRequest.locationName)

                                    VStack(spacing: IKPadding.medium) {
                                        Text(
                                            "!Confirming this connection will allow this device to access your Infomaniak account."
                                        )
                                        .multilineTextAlignment(.center)
                                        .font(.Custom.callout)
                                        .foregroundStyle(Color.Custom.textSecondary)

                                        HStack(spacing: IKPadding.medium) {
                                            Button("!Deny") {
                                                validateConnectionAttempt(approved: false)
                                            }
                                            .buttonStyle(.ikBordered)
                                            .ikButtonFullWidth(true)
                                            .ikButtonLoading(isLoading)
                                            .controlSize(.large)

                                            Button("!Approve") {
                                                validateConnectionAttempt(approved: true)
                                            }
                                            .buttonStyle(.ikBorderedProminent)
                                            .ikButtonFullWidth(true)
                                            .ikButtonLoading(isLoading)
                                            .controlSize(.large)
                                        }
                                    }
                                    .frame(maxHeight: .infinity, alignment: .bottom)
                                }
                            }
                        }
                        .padding(IKPadding.large)
                        .background {
                            RoundedRectangle(cornerRadius: IKRadius.large)
                                .strokeBorder(Color.Custom.cardOutline, lineWidth: 1)
                                .background(
                                    RoundedRectangle(cornerRadius: IKRadius.large)
                                        .fill(Color.backgroundSecondary)
                                )
                        }
                        .padding(IKPadding.medium)
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

    func validateConnectionAttempt(approved: Bool) {
        isLoading = true
        Task {
            do {
                _ = try await session.apiFetcher.validateConnectionAttempt(
                    id: connectionConfirmationRequest.id,
                    approved: approved
                )
                dismiss()
            } catch {
                // TODO: Error screens do not exist
            }
            isLoading = false
        }
    }
}

#Preview {
    ConnectionConfirmationView(
        session: InAppTwoFactorAuthenticationSession(user: PreviewUser.preview,
                                                     apiFetcher: MockInAppTwoFactorAuthenticationFetcher()),
        connectionConfirmationRequest: .preview
    )
}
