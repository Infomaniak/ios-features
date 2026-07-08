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
import SwiftUI

struct GeneralInformationSectionForm: View {
    @Environment(\.contactCardTheme) private var contactCardTheme

    @Binding var firstname: String
    @Binding var lastname: String
    @Binding var email: String
    @Binding var phone: String
    @Binding var company: String

    var body: some View {
        Section {
            TextField("\(Localizable.firstName)*", text: $firstname)
                .multilineTextAlignment(.leading)
            TextField("\(Localizable.lastName)*", text: $lastname)
                .multilineTextAlignment(.leading)
            TextField("\(Localizable.email)*", text: $email)
                .multilineTextAlignment(.leading)
                .keyboardType(.emailAddress)
            TextField("\(Localizable.phone)*", text: $phone)
                .multilineTextAlignment(.leading)
                .keyboardType(.phonePad)
            TextField(Localizable.company, text: $company)
                .multilineTextAlignment(.leading)
        } header: {
            Text(Localizable.generalInformation)
                .foregroundStyle(contactCardTheme.secondaryText)
                .font(.Custom.callout)
                .padding(.bottom, IKPadding.mini)
        }
    }
}
