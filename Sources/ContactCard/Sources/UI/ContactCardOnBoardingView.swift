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

import DesignSystem
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

@available(iOS 16.4, *)
struct ContactCardOnBoardingView: View {
    @Environment(\.contactCardTheme) private var contactCardTheme

    var body: some View {
        ScrollView {
            VStack {
                OnBoardingHeaderView()
                    .environment(\.contactCardTheme, contactCardTheme)
                    .padding(.top, IKPadding.giant)

                Text(MyString.contactCardOnBaoardingDescription)
                    .multilineTextAlignment(.center)
                    .font(.Custom.body)
                    .foregroundStyle(contactCardTheme.secondaryText)
                    .padding(.horizontal, IKPadding.medium)
                    .padding(.top, IKPadding.mini)
                    .padding(.bottom, IKPadding.huge)

                VStack(spacing: IKPadding.medium) {
                    FeatureItemCell(
                        icon: MyImage.contactCardOnBoardingFirstItem,
                        text: MyString.contactCardOnBaoardingFirstItem
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, IKPadding.mini)

                    FeatureItemCell(
                        icon: MyImage.contactCardOnBoardingSecondItem,
                        text: MyString.contactCardOnBaoardingSecondItem
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, IKPadding.mini)

                    FeatureItemCell(
                        icon: MyImage.contactCardOnBoardingThirdItem,
                        text: MyString.contactCardOnBaoardingThirdItem
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, IKPadding.mini)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, IKPadding.huge)
        }
        .scrollBounceBehavior(.basedOnSize)
        .safeAreaInset(edge: .bottom, content: {
            Button(MyString.contactCardOnBaoardingCreate) {
                // Nothing for now (navigation will be added later)
            }
            .buttonStyle(.ikBorderedProminent)
            .ikButtonFullWidth(true)
            .controlSize(.large)
            .ikButtonTheme(
                IKButtonTheme(
                    primary: contactCardTheme.primary,
                    secondary: contactCardTheme.secondary,
                    tertiary: Color.gray,
                    disabledPrimary: Color.gray,
                    disabledSecondary: Color.white,
                    error: Color.red,
                    smallFont: .body,
                    mediumFont: .headline
                )
            )
            .padding(.horizontal, IKPadding.large)
            .padding(.bottom, IKPadding.mini)
        })
    }
}

@available(iOS 16.4, *)
#Preview {
    ContactCardOnBoardingView()
}
