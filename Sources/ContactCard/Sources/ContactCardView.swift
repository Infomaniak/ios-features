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
    @Environment(\.contactCardTheme) private var contactCardTheme

    @LazyInjectService private var orientationManager: OrientationManageable

    @State private var contactCardProfile: ContactCard?
    @State private var myState: StateCardView = .onBoarding

    public let userProfile: UserProfile
    public let rootPath: URL

    public init(userProfile: UserProfile, rootPath: URL) {
        self.userProfile = userProfile
        self.rootPath = rootPath
    }

    public var body: some View {
        NavigationStack {
            ZStack {
                switch myState {
                case .onBoarding:
                    ContactCardOnBoardingView {
                        myState = .form(userProfile, rootPath, nil)
                    }
                    .environment(\.contactCardTheme, contactCardTheme)
                case .form(let profile, let root, let existingCard):
                    ContactCardFormView(myState: $myState, userProfile: profile, rootPath: root, existingCard: existingCard)
                        .environment(\.contactCardTheme, contactCardTheme)
                        .navigationTitle(Localizable.contactCardTitle)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarBackButtonHidden()
                case .qrCode(let profile, let card):
                    ContactCardQRCodeView(
                        myState: $myState,
                        userProfile: profile,
                        contactCard: card,
                        rootPath: rootPath,
                        onDelete: { contactCardProfile = nil },
                        onUpdate: { contactCardProfile = $0 }
                    )
                    .environment(\.contactCardTheme, contactCardTheme)
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
    }

    private func fetchContactCard() async {
        contactCardProfile = try? await ContactCardManager(rootPath: rootPath).load(userId: userProfile.id)
        guard let contactCardProfile else { return }
        myState = .qrCode(userProfile, contactCardProfile)
    }
}

@available(iOS 16.4, *)
#Preview {
    ContactCardView(userProfile: ProfileFake.fakeUserProfile, rootPath: URL.temporaryDirectory)
        .environment(\.contactCardTheme, .pink)
}

enum StateCardView {
    case onBoarding
    case form(UserProfile, URL, ContactCard?)
    case qrCode(UserProfile, ContactCard)
}

// MARK: - Fake Profile

enum ProfileFake {
    static let fakeUserProfile = UserProfile(
        id: 42,
        displayName: "Camille Mercier",
        firstName: "Camille",
        lastName: "Mercier",
        email: "camille.mercier@example.com",
        avatar: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=512&h=512&fit=crop"
    )

    static let fakeContactCardsLinks: [ContactCardLink] = [
        .init(type: .website, url: "https://joe.doe.fr"),
        .init(type: .linkedIn, url: "https://linkedin.com/in/joe.doe"),
        .init(type: .facebook, url: "https://facebook.com/in/joe.doe"),
        .init(type: .instagram, url: "https://instagram.com/in/joe.doe"),
        .init(type: .x, url: "https://x.com/in/joe.doe"),
        .init(type: .other, url: "https://other1.com/in/joe.doe"),
        .init(type: .other, url: "https://other2.com/in/joe.doe")
    ]

    static let fakeContactCard = ContactCard(
        id: 43,
        firstName: "Joe",
        lastName: "Doe",
        email: "joe.doe@example.com",
        phone: "+44 777 123 456",
        company: "Infomaniak",
        links: fakeContactCardsLinks
    )
}
#endif
