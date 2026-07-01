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
import InfomaniakCore
import InfomaniakCoreSwiftUI
import PhotosUI
import SwiftUI

private struct IdentifiableURL: Identifiable {
    let id = UUID()
    var value: String
}

struct ContactCardFormView: View {
    @Environment(\.contactCardTheme) private var contactCardTheme
    @Environment(\.dismiss) private var dismiss

    @Binding var path: NavigationPath

    @State var firstname = ""
    @State var lastname = ""
    @State var email = ""
    @State var phone = ""
    @State var company = ""

    @State var linkedin = ""
    @State var facebook = ""
    @State var instagram = ""
    @State var x = ""
    @State var website = ""
    @State private var additionalURLs: [IdentifiableURL] = []

    var userProfile: UserProfile
    var rootPath: URL
    var existingCard: ContactCard?

    init(path: Binding<NavigationPath>, userProfile: UserProfile, rootPath: URL, existingCard: ContactCard? = nil) {
        _path = path
        self.userProfile = userProfile
        self.rootPath = rootPath
        self.existingCard = existingCard
        _firstname = State(initialValue: existingCard?.firstName ?? userProfile.firstName)
        _lastname = State(initialValue: existingCard?.lastName ?? userProfile.lastName)
        _email = State(initialValue: existingCard?.email ?? userProfile.email)
        _phone = State(initialValue: existingCard?.phone ?? "")
        _company = State(initialValue: existingCard?.company ?? "")
        _linkedin = State(initialValue: existingCard?.links?.first(where: { $0.type == .linkedIn })?.url ?? "")
        _facebook = State(initialValue: existingCard?.links?.first(where: { $0.type == .facebook })?.url ?? "")
        _instagram = State(initialValue: existingCard?.links?.first(where: { $0.type == .instagram })?.url ?? "")
        _x = State(initialValue: existingCard?.links?.first(where: { $0.type == .x })?.url ?? "")
        let websiteLinks = existingCard?.links?.filter { $0.type == .website } ?? []
        _website = State(initialValue: websiteLinks.first?.url ?? "")
        _additionalURLs = State(initialValue: websiteLinks.dropFirst().map { IdentifiableURL(value: $0.url) })
    }

    var body: some View {
        Form {
            Section {
                TextField(MyString.formTextFieldFirstName, text: $firstname)
                TextField(MyString.formTextFieldLastName, text: $lastname)
                TextField(MyString.formTextFieldEmail, text: $email)
                    .keyboardType(.emailAddress)
                TextField(MyString.formTextFieldPhone, text: $phone)
                    .keyboardType(.phonePad)
                TextField(MyString.formTextFieldCompany, text: $company)
            } header: {
                Text(MyString.formGeneralInformation)
                    .foregroundStyle(contactCardTheme.secondaryText)
                    .font(.Custom.callout)
                    .padding(.bottom, IKPadding.mini)
            }
            .listRowBackground(contactCardTheme.background)

            Section {
                TextField(MyString.formTextFieldLinkedIn, text: $linkedin)
                    .keyboardType(.URL)
                TextField(MyString.formTextFieldFacebook, text: $facebook)
                    .keyboardType(.URL)
                TextField(MyString.formTextFieldInstagram, text: $instagram)
                    .keyboardType(.URL)
                TextField(MyString.formTextFieldX, text: $x)
                    .keyboardType(.URL)
                TextField(MyString.formTextFieldWebSite, text: $website)
                    .keyboardType(.URL)

                ForEach($additionalURLs) { $entry in
                    HStack {
                        TextField(MyString.formTextFieldOtherUrl, text: $entry.value)
                            .keyboardType(.URL)
                        Button {
                            withAnimation {
                                additionalURLs.removeAll { $0.id == entry.id }
                            }
                        } label: {
                            Image(.bin)
                                .foregroundStyle(contactCardTheme.primary)
                        }
                        .buttonStyle(.borderless)
                    }
                }

                Button {
                    withAnimation {
                        additionalURLs.append(IdentifiableURL(value: ""))
                    }
                } label: {
                    HStack {
                        Image(.add)
                            .foregroundStyle(contactCardTheme.primary)
                        Text(MyString.formButtonAddUrl)
                            .font(.Custom.headline)
                            .foregroundStyle(contactCardTheme.primary)
                    }
                }
            } header: {
                Text(MyString.formLinksAndSocialNetwork)
                    .foregroundStyle(contactCardTheme.secondaryText)
                    .font(.Custom.callout)
                    .padding(.bottom, IKPadding.mini)
            }
            .listRowBackground(contactCardTheme.background)
        }
        .padding(.top, IKPadding.large)
        .formStyle(.grouped)
        .scrollContentBackground(.hidden)
        .background(contactCardTheme.backgroundTint)
        .foregroundColor(contactCardTheme.primaryText)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button((existingCard == nil) ? MyString.formButtonCreate : MyString.formButtonRegister) {
                    var links: [ContactCardLink] = []
                    if !website.isEmpty { links.append(ContactCardLink(type: .website, url: website)) }
                    if !linkedin.isEmpty { links.append(ContactCardLink(type: .linkedIn, url: linkedin)) }
                    if !facebook.isEmpty { links.append(ContactCardLink(type: .facebook, url: facebook)) }
                    if !instagram.isEmpty { links.append(ContactCardLink(type: .instagram, url: instagram)) }
                    if !x.isEmpty { links.append(ContactCardLink(type: .x, url: x)) }
                    for entry in additionalURLs where !entry.value.isEmpty {
                        links.append(ContactCardLink(type: .other, url: entry.value))
                    }
                    let myCard = ContactCard(
                        id: existingCard?.id ?? userProfile.id,
                        firstName: self.firstname,
                        lastName: self.lastname,
                        email: self.email,
                        phone: self.phone,
                        company: self.company,
                        avatarURL: userProfile.avatar,
                        links: links
                    )
                    Task {
                        await ContactCardManager(rootPath: rootPath).save(contactCard: myCard, userId: userProfile.id)
                        path.append(ContactCardRoute.qrCode(userProfile, myCard))
                    }
                }
            }

            ToolbarItem(placement: .navigationBarLeading) {
                Button(MyString.formButtonCancel) {
                    dismiss()
                }
            }
        }
        .toolbarBackground(contactCardTheme.secondary.opacity(0.5), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct ContactCardFormViewPreview: View {
    @State var path = NavigationPath()

    var body: some View {
        ContactCardFormView(
            path: $path,
            userProfile: ProfileFake.fakeUserProfile,
            rootPath: FileManager.default.temporaryDirectory
        )
    }
}

#Preview {
    ContactCardFormViewPreview()
}
