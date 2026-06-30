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

    @State var firstname = ""
    @State var lastname = ""
    @State var email = ""
    @State var phone = ""

    @State var company = ""
    @State var website = ""
    @State var linkedin = ""

    let userProfile: UserProfile

    init(userProfile: UserProfile) {
        self.userProfile = userProfile
        _firstname = State(initialValue: userProfile.firstName)
        _lastname = State(initialValue: userProfile.lastName)
        _email = State(initialValue: userProfile.email)
        _phone = State(initialValue: "")
        _company = State(initialValue: "")
        _website = State(initialValue: "")
        _linkedin = State(initialValue: "")
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
                Button(MyString.formbuttonCreate) {
                    // TODO: Add logic to creat QRCode and register contactCard.json
                }
            }

            ToolbarItem(placement: .navigationBarLeading) {
                Button(MyString.formbuttonCancel) {
                    dismiss()
                }
            }
        }
        .toolbarBackground(contactCardTheme.secondary.opacity(0.5), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    ContactCardFormView(userProfile: ProfileFake.fakeUserProfile)
}
