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

struct FormContentView: View {
    @Environment(\.contactCardTheme) private var contactCardTheme

    @Binding var firstname: String
    @Binding var lastname: String
    @Binding var email: String
    @Binding var phone: String
    @Binding var company: String

    @Binding var linkedin: String
    @Binding var facebook: String
    @Binding var instagram: String
    @Binding var x: String
    @Binding var website: String
    @Binding var additionalURLs: [IdentifiableURL]

    @Binding var showValidationAlert: Bool

    var body: some View {
        Form {
            GeneralInformationSectionForm(
                firstname: $firstname,
                lastname: $lastname,
                email: $email,
                phone: $phone,
                company: $company
            )

            LinksSectionForm(
                linkedin: $linkedin,
                facebook: $facebook,
                instagram: $instagram,
                x: $x,
                website: $website,
                additionalURLs: $additionalURLs
            )
        }
        .alert(Localizable.alertTitle, isPresented: $showValidationAlert) {
            Button(Localizable.continueButton, role: .cancel) {}
        } message: {
            Text(Localizable.alertDescription)
        }
        .padding(.top, IKPadding.large)
        .formStyle(.grouped)
        .scrollContentBackground(.hidden)
        .foregroundColor(contactCardTheme.primaryText)
    }
}
