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
import InfomaniakCoreSwiftUI
import SwiftUI

enum MyString {
    static let contactCardOnBaoardingTitle = "Créez votre carte de visite"
    static let contactCardOnBaoardingDescription = "Partagez vos coordonnées d'un simple scan. Vos contacts vous enregistrent en une seconde — même hors ligne."
    static let contactCardOnBaoardingFirstItem = "Un QR code qui contient déjà tout"
    static let contactCardOnBaoardingSecondItem = "Aucun compte requis côté destinataire"
    static let contactCardOnBaoardingThirdItem = "Fonctionne hors ligne"
    static let contactCardOnBaoardingCreate = "Créer ma carte de visite"
}

enum MyImage {
    static let contactCardOnBoardingFirstItem = Image(systemName: "qrcode")
    static let contactCardOnBoardingSecondItem = Image(systemName: "checkmark")
    static let contactCardOnBoardingThirdItem = Image(systemName: "clock")
}

struct ContactCardOnBoardingView: View {
    @Environment(\.contactCardTheme) private var contactCardTheme

    var body: some View {
        Text("ContactCardOnBoardingView")
            .padding(value: .medium)
            .background(contactCardTheme.primary)
    }
}

#Preview {
    ContactCardOnBoardingView()
}
