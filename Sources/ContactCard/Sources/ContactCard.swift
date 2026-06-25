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
import SwiftUI

@available(iOS 16.4, *)
struct ContactCard: View {
    @Environment(\.contactCardTheme) private var contactCardTheme

    var body: some View {
        ContactCardOnBoardingView()
            .environment(\.contactCardTheme, .pink)
    }
}

@available(iOS 16.4, *)
#Preview {
    ContactCard()
        .environment(\.contactCardTheme, .pink)
}

// MARK: - ContactCardThemePreview

struct ContactCardThemePreview {
    let primary: Color
    let secondary: Color
    let primaryText: Color
    let secondaryText: Color
    let onAccent: Color
    let navBarBackground: Color
    let snackbarActionColor: Color

    static let pink = ContactCardThemePreview(
        primary: Color(red: 0.81, green: 0.12, blue: 0.39),
        secondary: Color(red: 0.96, green: 0.73, blue: 0.85),
        primaryText: Color(.black),
        secondaryText: Color(.darkGray),
        onAccent: Color.white,
        navBarBackground: Color(red: 0.20, green: 0.04, blue: 0.11),
        snackbarActionColor: Color(red: 0.96, green: 0.73, blue: 0.85)
    )

    static let blue = ContactCardThemePreview(
        primary: Color(red: 0.13, green: 0.46, blue: 0.96),
        secondary: Color(red: 0.72, green: 0.85, blue: 0.98),
        primaryText: Color(.black),
        secondaryText: Color(.darkGray),
        onAccent: Color.white,
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
}

enum MyImage {
    static let contactCardOnBoardingFirstItem = Image(systemName: "qrcode")
    static let contactCardOnBoardingSecondItem = Image(systemName: "checkmark")
    static let contactCardOnBoardingThirdItem = Image(systemName: "clock")
}
