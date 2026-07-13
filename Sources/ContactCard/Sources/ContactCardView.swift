/*
 Infomaniak Features - iOS
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

#if canImport(UIKit)
import Foundation
import InfomaniakCore
import InfomaniakCoreCommonUI
import InfomaniakDI
import SwiftUI

@available(iOS 16.4, *)
public struct ContactCardView: View {
    @LazyInjectService private var orientationManager: OrientationManageable

    @Environment(\.contactCardTheme) private var contactCardTheme
    @Environment(\.dismiss) private var dismiss

    @State private var path: [ContactCardRoute] = []

    public let userProfile: UserProfile
    public let rootPath: URL

    public init(userProfile: UserProfile, rootPath: URL) {
        self.userProfile = userProfile
        self.rootPath = rootPath
    }

    public var body: some View {
        NavigationStack(path: $path) {
            ProgressView()
                .environment(\.contactCardTheme, contactCardTheme)
                .navigationDestination(for: ContactCardRoute.self) { route in
                    switch route {
                    case .onBoarding:
                        ContactCardOnBoardingView(onCreateButtonTapped: {
                                                      withAnimation {
                                                          path.append(ContactCardRoute.form(userProfile, nil))
                                                      }
                                                  },
                                                  dismissModal: dismiss.callAsFunction)
                            .navigationTitle(Localizable.contactCardTitle)
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarBackButtonHidden()

                    case .form(let profile, let existingCard):
                        ContactCardFormView(
                            path: $path,
                            userProfile: profile,
                            rootPath: rootPath,
                            existingCard: existingCard,
                            dismissModal: dismiss.callAsFunction
                        )
                        .navigationTitle(Localizable.contactCardTitle)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarBackButtonHidden()

                    case .qrCode(let profile, let card):
                        ContactCardQRCodeView(
                            path: $path,
                            userProfile: profile,
                            contactCard: card,
                            rootPath: rootPath,
                            dismissModal: dismiss.callAsFunction
                        )
                        .navigationTitle(Localizable.contactCardTitle)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarBackButtonHidden()
                    }
                }
        }
        .task {
            await fetchAndNavigateIfCardExists()
        }
        .onAppear {
            if UIDevice.current.userInterfaceIdiom == .phone {
                UIDevice.current
                    .setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                orientationManager.setOrientationLock(.portrait)
                UIViewController.attemptRotationToDeviceOrientation()
            }
        }
        .onDisappear {
            if UIDevice.current.userInterfaceIdiom == .phone {
                orientationManager.setOrientationLock(.all)
                UIViewController.attemptRotationToDeviceOrientation()
            }
        }
    }

    private func fetchAndNavigateIfCardExists() async {
        let contactCardProfile = try? await ContactCardManager(rootPath: rootPath).cardFor(userId: userProfile.id)

        withAnimation {
            if let contactCardProfile {
                path.append(ContactCardRoute.qrCode(userProfile, contactCardProfile))
            } else {
                path.append(ContactCardRoute.onBoarding)
            }
        }
    }
}

@available(iOS 16.4, *)
#Preview {
    ContactCardView(userProfile: ProfileFake.fakeUserProfile, rootPath: URL.temporaryDirectory)
        .environment(\.contactCardTheme, .pink)
}

enum ContactCardRoute: Hashable {
    case onBoarding
    case form(UserProfile, ContactCard?)
    case qrCode(UserProfile, ContactCard)
}

#endif
