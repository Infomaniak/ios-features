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

struct MainContentView: View {
    @State private var isLoading = false

    let session: InAppTwoFactorAuthenticationSession
    let connectionConfirmationRequest: RemoteChallenge
    let onSuccess: ((Bool) -> Void)?
    let onError: ((Error) -> Void)?

    var body: some View {
        ZStack {
            Image(.backgroundLightSource)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: .infinity, alignment: .top)
                .offset(y: -332 / 2 + 32) // We already tried using alignment guides but this is simpler

            VStack(alignment: .leading, spacing: IKPadding.medium) {
                UserRowView(user: session.user)
                Divider()

                VStack {
                    VStack(spacing: IKPadding.medium) {
                        RowView(title: Localizable.twoFactorAuthWhenLabel) {
                            TimeAgoView(challengeCreatedAt: connectionConfirmationRequest.createdAt)
                        }

                        RowView(title: Localizable.twoFactorAuthDeviceLabel) {
                            HStack {
                                Text(connectionConfirmationRequest.device.name)
                                connectionConfirmationRequest.device.type.icon
                            }
                        }

                        RowView(
                            title: Localizable.twoFactorAuthLocationLabel,
                            description: connectionConfirmationRequest.location
                        )

                        VStack(spacing: IKPadding.medium) {
                            Text(Localizable.twoFactorAuthConfirmationDescription)
                                .multilineTextAlignment(.center)
                                .font(.Custom.callout)
                                .foregroundStyle(Color.Custom.textSecondary)

                            HStack(spacing: IKPadding.medium) {
                                Button(Localizable.buttonDeny) {
                                    validateConnectionAttempt(approved: false)
                                }
                                .buttonStyle(.ikBordered)
                                .ikButtonFullWidth(true)
                                .ikButtonLoading(isLoading)
                                .controlSize(.large)

                                Button(Localizable.buttonApprove) {
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
    }

    func validateConnectionAttempt(approved: Bool) {
        isLoading = true
        Task {
            do {
                _ = try await session.apiFetcher.validateChallenge(
                    uuid: connectionConfirmationRequest.uuid,
                    approved: approved
                )
                onSuccess?(approved)
            } catch {
                onError?(error)
            }
            isLoading = false
        }
    }
}

#Preview {
    MainContentView(session: InAppTwoFactorAuthenticationSession(user: PreviewUser.preview,
                                                                 apiFetcher: MockInAppTwoFactorAuthenticationFetcher()),
                    connectionConfirmationRequest: .preview, onSuccess: nil, onError: nil)
}
