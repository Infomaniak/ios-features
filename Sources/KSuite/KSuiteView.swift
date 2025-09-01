/*
 iOS Features
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
import KSuiteUtils
import SwiftUI

public struct KSuiteView: View {
    @Environment(\.dismiss) private var dismiss

    private let configuration: KSuiteConfiguration
    private let isAdmin: Bool

    public init(configuration: KSuiteConfiguration, isAdmin: Bool) {
        self.configuration = configuration
        self.isAdmin = isAdmin
    }

    public var body: some View {
        VStack(spacing: IKPadding.huge) {
            KSuiteResources.background.swiftUIImage
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: IKPadding.huge) {
                VStack(alignment: .leading, spacing: IKPadding.medium) {
                    Text(configuration.title)
                        .multilineTextAlignment(.center)
                        .font(FontHelper.title)
                        .foregroundStyle(ColorHelper.primary)
                        .frame(maxWidth: .infinity, alignment: .center)

                    Text(configuration.description)
                }

                VStack(alignment: .leading, spacing: IKPadding.medium) {
                    ForEach(configuration.labels) { label in
                        Label {
                            if let attributedString = try? AttributedString(markdown: label.text) {
                                Text(attributedString)
                            } else {
                                Text(label.text)
                            }
                        } icon: {
                            label.icon
                                .iconSize(.large)
                        }
                    }
                }

                Text(isAdmin ? KSuiteLocalizable.kSuiteUpgradeDetails : KSuiteLocalizable.kSuiteUpgradeDetailsContactAdmin)

                Button {
                    dismiss()
                } label: {
                    Text(KSuiteUtilsLocalizable.buttonClose)
                        .foregroundStyle(ColorHelper.primary)
                }
                .ikButtonFullWidth(true)
                .controlSize(.large)
                .tint(ColorHelper.reversedPrimary)
                .buttonStyle(.ikBorderedProminent)
            }
            .padding(.horizontal, value: .large)
            .font(FontHelper.body)
            .foregroundStyle(ColorHelper.secondary)
        }
        .padding(.bottom, value: .large)
        .background(ColorHelper.backgroundPrimary)
    }
}

#Preview("Standard") {
    KSuiteView(configuration: .standard, isAdmin: false)
}

#Preview("Business") {
    KSuiteView(configuration: .business, isAdmin: false)
}

#Preview("Entreprise") {
    KSuiteView(configuration: .enterprise, isAdmin: false)
}
