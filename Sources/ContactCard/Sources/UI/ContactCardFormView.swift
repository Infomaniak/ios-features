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

struct ContactCardFormView: View {
    @Environment(\.contactCardTheme) private var contactCardTheme
    @Environment(\.dismiss) private var dismiss

    @Binding var path: NavigationPath

    @State var firstname = ""
    @State var lastname = ""
    @State var email = ""
    @State var phone = ""

    @State var company = ""
    @State var website = ""
    @State var linkedin = ""

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
        _website = State(initialValue: existingCard?.links?.first(where: { $0.type == .website })?.url ?? "")
        _linkedin = State(initialValue: existingCard?.links?.first(where: { $0.type == .linkedIn })?.url ?? "")
    }

    var body: some View {
        Form {
            ContactCardAvatarPickerView(userProfile: userProfile)
                .environment(\.contactCardTheme, contactCardTheme)
                .frame(maxWidth: .infinity)
                .listRowBackground(contactCardTheme.background)

            Section {
                TextField(MyString.formTextFieldFirstName, text: $firstname)
                TextField(MyString.formTextFieldLastName, text: $lastname)
                TextField(MyString.formTextFieldEmail, text: $email)
                    .keyboardType(.emailAddress)
                TextField(MyString.formTextFieldPhone, text: $phone)
                    .keyboardType(.phonePad)
            } footer: {
                Text(MyString.formRequiredFields)
                    .foregroundStyle(contactCardTheme.secondaryText)
                    .padding(.bottom, IKPadding.medium)
            }
            .listRowBackground(Color(UIColor.systemGray5))

            Section {
                TextField(MyString.formTextFieldCompany, text: $company)
                TextField(MyString.formTextFieldWebSite, text: $website)
                    .keyboardType(.URL)
                TextField(MyString.formTextFieldLinkedIn, text: $linkedin)
            } footer: {
                Text(MyString.formNoRequiredFields)
                    .foregroundStyle(contactCardTheme.secondaryText)
            }
            .listRowBackground(Color(UIColor.systemGray5))
        }
        .formStyle(.grouped)
        .scrollContentBackground(.hidden)
        .background(contactCardTheme.background)
        .foregroundColor(contactCardTheme.primaryText)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button((existingCard == nil) ? MyString.formButtonCreate : MyString.formButtonRegister) {
                    let links: [ContactCardLink] = [
                        ContactCardLink(type: .website, url: self.website),
                        ContactCardLink(type: .linkedIn, url: self.linkedin)
                    ]
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
