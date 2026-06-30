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

import Foundation
import InfomaniakCore
import SwiftUI

@available(iOS 16.4, *)
struct ContactCardView: View {
    @Environment(\.contactCardTheme) private var contactCardTheme

    @State private var path = NavigationPath()

    let userId: Int
    @State private var contactCardProfile: ContactCard? = nil

    var body: some View {
        NavigationStack(path: $path) {
            if let contactCardProfile {
                ContactCardQRCodeView(contactCard: contactCardProfile)
                    .environment(\.contactCardTheme, .pink)
            } else {
                ContactCardOnBoardingView(onCreateButtonTapped: {
                    path.append(ContactCardRoute.form(ProfileFake.fakeUserProfile))
                })
                .environment(\.contactCardTheme, .pink)
                .navigationDestination(for: ContactCardRoute.self) { route in
                    switch route {
                    case .form(let profile):
                        ContactCardFormView(userProfile: profile)
                            .environment(\.contactCardTheme, .pink)
                            .navigationTitle(MyString.formTitle)
                            .navigationBarBackButtonHidden()
                    }
                }
            }
        }.task {
            await fetchContactCard()
        }
    }

    private func fetchContactCard() async {
        // TODO: Change this, the goal is get contactCard with path if existe
        contactCardProfile = nil
    }
}

@available(iOS 16.4, *)
#Preview {
    ContactCardView(userId: 42)
        .environment(\.contactCardTheme, .pink)
}

enum ContactCardRoute: Hashable {
    case form(UserProfile)
}

// MARK: - ContactCardThemePreview

struct ContactCardThemePreview {
    let primary: Color
    let secondary: Color
    let primaryText: Color
    let secondaryText: Color
    let onAccent: Color
    let background: Color
    let navBarBackground: Color
    let snackbarActionColor: Color

    static let pink = ContactCardThemePreview(
        primary: Color(red: 0.81, green: 0.12, blue: 0.39),
        secondary: Color(red: 0.96, green: 0.73, blue: 0.85),
        primaryText: Color(.black),
        secondaryText: Color(.darkGray),
        onAccent: Color.white,
        background: Color(UIColor.systemGray6),
        navBarBackground: Color(red: 0.20, green: 0.04, blue: 0.11),
        snackbarActionColor: Color(red: 0.96, green: 0.73, blue: 0.85)
    )

    static let blue = ContactCardThemePreview(
        primary: Color(red: 0.13, green: 0.46, blue: 0.96),
        secondary: Color(red: 0.72, green: 0.85, blue: 0.98),
        primaryText: Color(.black),
        secondaryText: Color(.darkGray),
        onAccent: Color.white,
        background: Color(UIColor.systemGray6),
        navBarBackground: Color(red: 0.04, green: 0.13, blue: 0.29),
        snackbarActionColor: Color(red: 0.72, green: 0.85, blue: 0.98)
    )
}

private struct ContactCardThemeKey: EnvironmentKey {
    static let defaultValue: ContactCardThemePreview = .pink
}

extension EnvironmentValues {
    var contactCardTheme: ContactCardThemePreview {
        get { self[ContactCardThemeKey.self] }
        set { self[ContactCardThemeKey.self] = newValue }
    }
}

// MARK: Enum

enum MyString {
    static let contactCardOnBaoardingTitle = "Créez votre carte de visite"
    static let contactCardOnBaoardingDescription = "Partagez vos coordonnées d'un simple scan. Vos contacts vous enregistrent en une seconde — même hors ligne."
    static let contactCardOnBaoardingFirstItem = "Un QR code qui contient déjà tout"
    static let contactCardOnBaoardingSecondItem = "Aucun compte requis côté destinataire"
    static let contactCardOnBaoardingThirdItem = "Fonctionne hors ligne"
    static let contactCardOnBaoardingCreate = "Créer ma carte de visite"

    static let formTextFieldFirstName = "Prénom"
    static let formTextFieldLastName = "Nom"
    static let formTextFieldEmail = "Adresse e-mail"
    static let formTextFieldPhone = "Numéro de téléphone"
    static let formTextFieldCompany = "Entreprise"
    static let formTextFieldWebSite = "Site internet"
    static let formTextFieldLinkedIn = "LinkedIn"
    static let formRequiredFields = "Champs obligatoires."
    static let formNoRequiredFields = "Champs facultatifs."
    static let formbuttonCreate = "Créer"
    static let formbuttonCancel = "Annuler"
    static let formTitle = "Carte de visite"

    static let qrCodeShared = "Partager"
    static let qrCodeSharedImage = "square.and.arrow.up"
}

enum MyImage {
    static let contactCardOnBoardingFirstItem = Image(systemName: "qrcode")
    static let contactCardOnBoardingSecondItem = Image(systemName: "checkmark")
    static let contactCardOnBoardingThirdItem = Image(systemName: "clock")
}

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
        .init(type: .linkedIn, url: "https://linkedin.com/in/joe.doe")
    ]

    static let fakeContactCard = ContactCard(
        id: 43,
        firstName: "Joe",
        lastName: "Doe",
        email: "joe.doe@example.com",
        phone: "+44 777 123 456",
        links: fakeContactCardsLinks
    )
}
