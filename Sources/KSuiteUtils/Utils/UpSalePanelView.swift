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
import SwiftUI

public struct UpSalePanelView: View {
    @Environment(\.dismiss) private var dismiss

    let headerImage: Image
    let title: String
    let description: String

    let labels: [KSuiteLabel]
    let additionalText: String

    public init(
        headerImage: Image,
        title: String,
        description: String,
        labels: [KSuiteLabel],
        additionalText: String
    ) {
        self.headerImage = headerImage
        self.title = title
        self.description = description
        self.labels = labels
        self.additionalText = additionalText
    }

    public var body: some View {
        VStack(spacing: IKPadding.huge) {
            headerImage
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: IKPadding.huge) {
                VStack(alignment: .leading, spacing: IKPadding.medium) {
                    Text(title)
                        .multilineTextAlignment(.center)
                        .font(FontHelper.title)
                        .foregroundStyle(ColorHelper.primary)
                        .frame(maxWidth: .infinity)

                    Text(description)
                }

                VStack(alignment: .leading, spacing: IKPadding.medium) {
                    ForEach(labels) { label in
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

                Text(additionalText)

                Button(action: dismiss.callAsFunction) {
                    Text(KSuiteUtilsLocalizable.buttonClose)
                        .foregroundStyle(ColorHelper.primary)
                }
                .ikButtonFullWidth(true)
                .controlSize(.large)
                .tint(ColorHelper.reversedPrimary)
                .buttonStyle(.ikBorderedProminent)
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, value: .large)
            .frame(maxWidth: 600)
            .font(FontHelper.body)
            .foregroundStyle(ColorHelper.secondary)
            .layoutPriority(1)
        }
        .padding(.bottom, value: .large)
        .background(ColorHelper.backgroundPrimary)
    }
}

#Preview {
    UpSalePanelView(
        headerImage: Image(systemName: "photo"),
        title: "Some title",
        description: "Some description",
        labels: [
            KSuiteLabel(icon: Image(systemName: "photo"), text: "Some **bold** label"),
            KSuiteLabel(icon: Image(systemName: "location"), text: "Some **bold** label"),
            KSuiteLabel(icon: Image(systemName: "bus"), text: "Some **bold** label")
        ],
        additionalText: "Some additional text"
    )
}

#Preview {
    UpSalePanelView(
        headerImage: Image(systemName: "photo"),
        title: "Some longer title that can be multiline and explain what is the upsell about",
        description: "Some longer description that can be multiline and explain what is the upsell about",
        labels: [
            KSuiteLabel(icon: Image(systemName: "photo"), text: "Some **bold** label"),
            KSuiteLabel(icon: Image(systemName: "location"), text: "Some **bold** label"),
            KSuiteLabel(icon: Image(systemName: "bus"), text: "Some **bold** label")
        ],
        additionalText: "Some additional text"
    )
}
