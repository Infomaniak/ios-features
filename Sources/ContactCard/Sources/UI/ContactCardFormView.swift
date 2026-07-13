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
import InfomaniakCore
import InfomaniakCoreCommonUI
import InfomaniakCoreUIResources
import InfomaniakDI
import OSLog
import SwiftUI

@available(iOS 16.4, *)
struct ContactCardFormView: View {
    @Environment(\.contactCardTheme) private var contactCardTheme
    @Environment(\.dismiss) private var dismiss

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var company = ""

    @State private var linkedIn = ""
    @State private var facebook = ""
    @State private var instagram = ""
    @State private var x = ""
    @State private var website = ""
    @State private var additionalURLs: [String] = []

    @State private var isShowingValidationAlert = false

    @Binding private var path: [ContactCardRoute]

    var userProfile: UserProfile
    var rootPath: URL
    var existingCard: ContactCard?

    let onCancel: (() -> Void)?

    private var isFormValid: Bool {
        !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !phone.isEmpty
    }

    init(
        path: Binding<[ContactCardRoute]>,
        userProfile: UserProfile,
        rootPath: URL,
        existingCard: ContactCard? = nil,
        onCancel: (() -> Void)? = nil
    ) {
        _path = path
        self.userProfile = userProfile
        self.rootPath = rootPath
        self.existingCard = existingCard
        self.onCancel = onCancel
        _firstName = State(initialValue: existingCard?.firstName ?? userProfile.firstName)
        _lastName = State(initialValue: existingCard?.lastName ?? userProfile.lastName)
        _email = State(initialValue: existingCard?.email ?? userProfile.email)
        _phone = State(initialValue: existingCard?.phone ?? "")
        _company = State(initialValue: existingCard?.company ?? "")
        _linkedIn = State(initialValue: existingCard?.links?.first { $0.type == .linkedIn }?.url ?? "")
        _facebook = State(initialValue: existingCard?.links?.first { $0.type == .facebook }?.url ?? "")
        _instagram = State(initialValue: existingCard?.links?.first { $0.type == .instagram }?.url ?? "")
        _x = State(initialValue: existingCard?.links?.first { $0.type == .x }?.url ?? "")
        let websiteLinks = existingCard?.links?.filter { $0.type == .website } ?? []
        _website = State(initialValue: websiteLinks.first?.url ?? "")
        let otherLinks = existingCard?.links?.filter { $0.type == .other } ?? []
        _additionalURLs = State(initialValue: otherLinks.map { $0.url })
    }

    var body: some View {
        FormContentView(
            firstName: $firstName,
            lastName: $lastName,
            email: $email,
            phone: $phone,
            company: $company,
            linkedIn: $linkedIn,
            facebook: $facebook,
            instagram: $instagram,
            x: $x,
            website: $website,
            additionalURLs: $additionalURLs,
            isShowingValidationAlert: $isShowingValidationAlert
        )
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button((existingCard == nil) ? Localizable.buttonCreate : CoreUILocalizable.buttonSave) {
                    if isFormValid {
                        if existingCard == nil {
                            @InjectService var matomo: MatomoUtils
                            matomo.track(eventWithCategory: .contactCard, name: "create")
                        }
                        createCard()
                    } else {
                        isShowingValidationAlert = true
                    }
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(CoreUILocalizable.buttonCancel) {
                    if existingCard != nil {
                        withAnimation {
                            dismiss()
                        }
                    } else {
                        onCancel?()
                    }
                }
            }
        }
        .toolbarBackground(contactCardTheme.navBarBackground, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .matomoView(view: ["ContactCardFromView"])
    }

    private func createCard() {
        var links: [ContactCardLink] = []

        if !website.isEmpty { links.append(ContactCardLink(type: .website, url: website)) }
        if !linkedIn.isEmpty { links.append(ContactCardLink(type: .linkedIn, url: linkedIn)) }
        if !facebook.isEmpty { links.append(ContactCardLink(type: .facebook, url: facebook)) }
        if !instagram.isEmpty { links.append(ContactCardLink(type: .instagram, url: instagram)) }
        if !x.isEmpty { links.append(ContactCardLink(type: .x, url: x)) }
        for entry in additionalURLs where !entry.isEmpty {
            links.append(ContactCardLink(type: .other, url: entry))
        }

        let newCard = ContactCard(
            id: existingCard?.id ?? userProfile.id,
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
            company: company,
            avatarURL: userProfile.avatar,
            links: links
        )

        Task {
            do {
                try await ContactCardManager(rootPath: rootPath).save(contactCard: newCard, userId: userProfile.id)
                withAnimation {
                    if existingCard != nil {
                        dismiss()
                    } else {
                        path.append(ContactCardRoute.qrCode(userProfile, newCard))
                    }
                }
            } catch {
                Logger.general.error("Error save contact card :\(error)")
            }
        }
    }
}
#endif
