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

import DesignSystem
import InfomaniakCoreSwiftUI
import SwiftUI

enum LoadingState {
    case idle
    case loadingApprove
    case loadingDeny
}

struct MainContentView: View {
    @State private var loadingState: LoadingState = .idle

    let session: InAppTwoFactorAuthenticationSession
    let connectionConfirmationRequest: RemoteChallenge
    let onSuccess: ((Bool) -> Void)?
    let onError: ((TwoFactorAuthError) -> Void)?

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
                                .ikButtonLoading(loadingState == .loadingDeny)
                                .disabled(loadingState == .loadingApprove)
                                .controlSize(.large)

                                Button(Localizable.buttonApprove) {
                                    validateConnectionAttempt(approved: true)
                                }
                                .buttonStyle(.ikBorderedProminent)
                                .ikButtonFullWidth(true)
                                .ikButtonLoading(loadingState == .loadingApprove)
                                .disabled(loadingState == .loadingDeny)
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
        loadingState = approved ? .loadingApprove : .loadingDeny
        Task {
            do {
                _ = try await session.apiFetcher.validateChallenge(
                    uuid: connectionConfirmationRequest.uuid,
                    approved: approved
                )
                onSuccess?(approved)
            } catch let error as TwoFactorAuthError {
                onError?(error)
            }
            loadingState = .idle
        }
    }
}

#Preview {
    MainContentView(session: InAppTwoFactorAuthenticationSession(user: PreviewUser.preview,
                                                                 apiFetcher: MockInAppTwoFactorAuthenticationFetcher()),
                    connectionConfirmationRequest: .preview, onSuccess: nil, onError: nil)
}
