//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.

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
