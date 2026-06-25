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
import InfomaniakCoreSwiftUI
import PhotosUI
import SwiftUI

struct ContactCardFormView: View {
    @Environment(\.contactCardTheme) private var contactCardTheme

    @State var firstname = ""
    @State var lastname = ""
    @State var email = ""
    @State var phone = ""

    @State var company = ""
    @State var website = ""
    @State var linkedin = ""

    var body: some View {
        Form {
            ContactCardAvatarPickerView()
                .frame(maxWidth: .infinity)

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
            .listRowBackground(Color(UIColor.systemGray6))

            Section {
                TextField(MyString.formTextFieldCompany, text: $company)
                TextField(MyString.formTextFieldWebSite, text: $website)
                    .keyboardType(.URL)
                TextField(MyString.formTextFieldLinkedIn, text: $linkedin)
            } footer: {
                Text(MyString.formNoRequiredFields)
                    .foregroundStyle(contactCardTheme.secondaryText)
            }
            .listRowBackground(Color(UIColor.systemGray6))
        }
        .formStyle(.grouped)
        .scrollContentBackground(.hidden)
        .background(contactCardTheme.onAccent)
        .foregroundColor(contactCardTheme.primaryText)
    }
}

#Preview {
    ContactCardFormView()
}
