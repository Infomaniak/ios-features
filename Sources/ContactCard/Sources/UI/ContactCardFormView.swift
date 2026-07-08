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
import InfomaniakCoreUIResources
import OSLog
import SwiftUI

struct IdentifiableURL: Identifiable {
    let id = UUID()
    var value: String
}

@available(iOS 16.4, *)
struct ContactCardFormView: View {
    @Environment(\.contactCardTheme) private var contactCardTheme
    @Environment(\.dismiss) private var dismiss

    @Binding var rootViewState: ContactCardView.RootViewState

    @State private var firstname = ""
    @State private var lastname = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var company = ""

    @State private var linkedin = ""
    @State private var facebook = ""
    @State private var instagram = ""
    @State private var x = ""
    @State private var website = ""
    @State private var additionalURLs: [IdentifiableURL] = []

    @State private var showValidationAlert = false

    var userProfile: UserProfile
    var rootPath: URL
    var existingCard: ContactCard?

    private var isFormValid: Bool {
        !firstname.isEmpty && !lastname.isEmpty && !email.isEmpty && !phone.isEmpty
    }

    init(
        rootViewState: Binding<ContactCardView.RootViewState>,
        userProfile: UserProfile,
        rootPath: URL,
        existingCard: ContactCard? = nil
    ) {
        _rootViewState = rootViewState
        self.userProfile = userProfile
        self.rootPath = rootPath
        self.existingCard = existingCard
        _firstname = State(initialValue: existingCard?.firstName ?? userProfile.firstName)
        _lastname = State(initialValue: existingCard?.lastName ?? userProfile.lastName)
        _email = State(initialValue: existingCard?.email ?? userProfile.email)
        _phone = State(initialValue: existingCard?.phone ?? "")
        _company = State(initialValue: existingCard?.company ?? "")
        _linkedin = State(initialValue: existingCard?.links?.first { $0.type == .linkedIn }?.url ?? "")
        _facebook = State(initialValue: existingCard?.links?.first { $0.type == .facebook }?.url ?? "")
        _instagram = State(initialValue: existingCard?.links?.first { $0.type == .instagram }?.url ?? "")
        _x = State(initialValue: existingCard?.links?.first { $0.type == .x }?.url ?? "")
        let websiteLinks = existingCard?.links?.filter { $0.type == .website } ?? []
        _website = State(initialValue: websiteLinks.first?.url ?? "")
        let otherLinks = existingCard?.links?.filter { $0.type == .other } ?? []
        _additionalURLs = State(initialValue: otherLinks.map { IdentifiableURL(value: $0.url) })
    }

    var body: some View {
        FormContentView(
            firstname: $firstname,
            lastname: $lastname,
            email: $email,
            phone: $phone,
            company: $company,
            linkedin: $linkedin,
            facebook: $facebook,
            instagram: $instagram,
            x: $x,
            website: $website,
            additionalURLs: $additionalURLs,
            showValidationAlert: $showValidationAlert
        )
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button((existingCard == nil) ? Localizable.buttonCreate : CoreUILocalizable.buttonSave) {
                    if isFormValid {
                        create()
                    } else {
                        showValidationAlert = true
                    }
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(CoreUILocalizable.buttonCancel) {
                    dismiss()
                }
            }
        }
        .background(contactCardTheme.navBarBackground)
        .toolbarBackground(.hidden, for: .navigationBar)
    }

    private func create() {
        var links: [ContactCardLink] = []
        if !website.isEmpty { links.append(ContactCardLink(type: .website, url: website)) }
        if !linkedin.isEmpty { links.append(ContactCardLink(type: .linkedIn, url: linkedin)) }
        if !facebook.isEmpty { links.append(ContactCardLink(type: .facebook, url: facebook)) }
        if !instagram.isEmpty { links.append(ContactCardLink(type: .instagram, url: instagram)) }
        if !x.isEmpty { links.append(ContactCardLink(type: .x, url: x)) }
        for entry in additionalURLs where !entry.value.isEmpty {
            links.append(ContactCardLink(type: .other, url: entry.value))
        }
        let newCard = ContactCard(
            id: existingCard?.id ?? userProfile.id,
            firstName: firstname,
            lastName: lastname,
            email: email,
            phone: phone,
            company: company,
            avatarURL: userProfile.avatar,
            links: links
        )
        Task {
            do {
                try await ContactCardManager(rootPath: rootPath).save(contactCard: newCard, userId: userProfile.id)
                rootViewState = .qrCode(userProfile, newCard)
            } catch {
                Logger.general.error("Error save contact card :\(error)")
            }
        }
    }
}
#endif
