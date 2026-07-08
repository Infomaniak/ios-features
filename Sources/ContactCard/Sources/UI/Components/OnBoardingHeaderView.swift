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
import DesignSystem
import InfomaniakCoreSwiftUI
import SwiftUI

struct OnboardingHeaderView: View {
    @Environment(\.contactCardTheme) private var contactCardTheme

    var body: some View {
        VStack(spacing: IKPadding.huge) {
            contactCardTheme.onboardingImage
                .resizable()
                .scaledToFit()
                .foregroundColor(contactCardTheme.primary)

            Text(Localizable.contactCardOnBoardingTitle)
                .multilineTextAlignment(.center)
                .font(.Custom.title1)
                .foregroundStyle(contactCardTheme.primaryText)
        }
    }
}

#Preview {
    OnboardingHeaderView()
}
#endif
