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
public struct ContactCardView: View {
    @Environment(\.contactCardTheme) private var contactCardTheme

    @State private var contactCardProfile: ContactCard? = nil
    public let userProfile: UserProfile
    public let rootPath: URL

    @State var myState: StateCardView = .onBoarding

    public init(userProfile: UserProfile, rootPath: URL) {
        self.userProfile = userProfile
        self.rootPath = rootPath
    }

    public var body: some View {
        NavigationStack {
            ZStack {
                switch myState {
                case .onBoarding:
                    ContactCardOnBoardingView(onCreateButtonTapped: {
                        myState = .form(userProfile, rootPath, nil)
                    })
                    .environment(\.contactCardTheme, contactCardTheme)
                case .form(let profile, let root, let existingCard):
                    ContactCardFormView(myState: $myState, userProfile: profile, rootPath: root, existingCard: existingCard)
                        .environment(\.contactCardTheme, contactCardTheme)
                        .navigationTitle(MyString.formTitle)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarBackButtonHidden()
                case .qrCode(let profile, let card):
                    ContactCardQRCodeView(
                        myState: $myState,
                        userProfile: profile,
                        contactCard: card,
                        rootPath: rootPath,
                        onDelete: { self.contactCardProfile = nil },
                        onUpdate: { self.contactCardProfile = $0 }
                    )
                    .environment(\.contactCardTheme, contactCardTheme)
                    .navigationTitle(MyString.formTitle)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden()
                }
            }
        }
        .task {
            await fetchContactCard()
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

// MARK: - Enum

enum MyString {
    static let contactCardOnBaoardingTitle = "Créez votre carte de visite"
    static let contactCardOnBaoardingDescription = "Faites scanner votre QR code d’un simple geste. vos contacts vous enregistrent en un clin d’oeil, avec ou sans connexion"
    static let contactCardOnBaoardingFirstItem = "Toutes vos informations dans un QR code"
    static let contactCardOnBaoardingSecondItem = "Aucun compte requis côté destinataire"
    static let contactCardOnBaoardingThirdItem = "Toujours accessible, même hors-ligne"
    static let contactCardOnBaoardingCreate = "Commencer"

    static let formTextFieldFirstName = "Prénom"
    static let formTextFieldLastName = "Nom"
    static let formTextFieldEmail = "Mail"
    static let formTextFieldPhone = "Téléphone"
    static let formTextFieldCompany = "Entreprise"

    static let formTextFieldLinkedIn = "LinkedIn"
    static let formTextFieldFacebook = "Facebook"
    static let formTextFieldInstagram = "Instagram"
    static let formTextFieldX = "X"
    static let formTextFieldWebSite = "Site internet"
    static let formTextFieldOtherUrl = "Autre URL"
    static let formButtonAddUrl = "Ajouter une URL"

    static let formGeneralInformation = "Informations générales"
    static let formLinksAndSocialNetwork = "Liens et réseaux sociaux"

    static let formButtonRegister = "Enregistrer"
    static let formButtonCreate = "Créer"
    static let formButtonCancel = "Annuler"
    static let formTitle = "Carte de visite"

    static let validationAlertTitle = "Champs obligatoires"
    static let validationAlertMessage = "Veuillez remplir tous les champs obligatoires (prénom, nom, email, téléphone)."

    static let qrCodeShared = "Partager"
    static let qrCodeSharedImage = "square.and.arrow.up"
    static let qrCodeGenerationError = "Impossible de générer le QR code"
    static let qrCodeMenuEdit = "Modifier"
    static let qrCodeMenuDelete = "Supprimer"

    static let qrCodeDeleteAlertTitle = "Supprimer la carte de visite"
    static let qrCodeDeleteAlertMessage = "La suppression désactive votre carte et son QR. Les personnes qui vous ont déjà enregistré ne sont pas affectées. Vous pourrez la recréer à tout moment."
    static let qrCodeDeleteAlertConfirm = "Supprimer"
    static let qrCodeDeleteAlertCancel = "Annuler"
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
