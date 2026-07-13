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

struct LinksSectionForm: View {
    @Environment(\.contactCardTheme) private var contactCardTheme

    @Binding var linkedin: String
    @Binding var facebook: String
    @Binding var instagram: String
    @Binding var x: String
    @Binding var website: String
    @Binding var additionalURLs: [String]

    var body: some View {
        Section {
            TextField(Localizable.linkedIn, text: $linkedin)
                .multilineTextAlignment(.leading)
                .keyboardType(.URL)
            TextField(Localizable.facebook, text: $facebook)
                .multilineTextAlignment(.leading)
                .keyboardType(.URL)
            TextField(Localizable.instagram, text: $instagram)
                .multilineTextAlignment(.leading)
                .keyboardType(.URL)
            TextField(Localizable.x, text: $x)
                .multilineTextAlignment(.leading)
                .keyboardType(.URL)
            TextField(Localizable.webSite, text: $website)
                .multilineTextAlignment(.leading)
                .keyboardType(.URL)
            AdditionalURLsRows(additionalURLs: $additionalURLs)
            AddURLButton(additionalURLs: $additionalURLs)
        } header: {
            Text(Localizable.linksAndSocialNetwork)
                .foregroundStyle(contactCardTheme.secondaryText)
                .font(.Custom.callout)
                .padding(.bottom, IKPadding.mini)
        }
    }
}
