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

    @State private var contactCardProfile: ContactCard?
    @State private var rootViewState: RootViewState = .onboarding

    public let userProfile: UserProfile
    public let rootPath: URL

    public init(userProfile: UserProfile, rootPath: URL) {
        self.userProfile = userProfile
        self.rootPath = rootPath
    }

    public var body: some View {
        NavigationStack {
            ZStack {
                switch rootViewState {
                case .onboarding:
                    ContactCardOnBoardingView {
                        withAnimation {
                            rootViewState = .form(userProfile, rootPath, nil)
                        }
                    }
                    .environment(\.contactCardTheme, contactCardTheme)
                case .form(let profile, let rootPath, let existingCard):
                    ContactCardFormView(
                        rootViewState: $rootViewState,
                        userProfile: profile,
                        rootPath: rootPath,
                        existingCard: existingCard
                    )
                    .navigationTitle(Localizable.contactCardTitle)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden()
                case .qrCode(let profile, let card):
                    ContactCardQRCodeView(
                        rootViewState: $rootViewState,
                        userProfile: profile,
                        contactCard: card,
                        rootPath: rootPath,
                        onDelete: { contactCardProfile = nil },
                        onUpdate: { contactCardProfile = $0 }
                    )
                    .navigationTitle(Localizable.contactCardTitle)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden()
                }
            }
        }
        .task {
            await fetchContactCard()
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

    private func fetchContactCard() async {
        contactCardProfile = try? await ContactCardManager(rootPath: rootPath).cardFor(userId: userProfile.id)
        guard let contactCardProfile else { return }
        withAnimation {
            rootViewState = .qrCode(userProfile, contactCardProfile)
        }
    }
}

@available(iOS 16.4, *)
#Preview {
    ContactCardView(userProfile: ProfileFake.fakeUserProfile, rootPath: URL.temporaryDirectory)
        .environment(\.contactCardTheme, .pink)
}

@available(iOS 16.4, *)
extension ContactCardView: View {
    enum RootViewState {
        case onboarding
        case form(UserProfile, URL, ContactCard?)
        case qrCode(UserProfile, ContactCard)
    }
}

#endif
