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

    private let labels: [KSuiteLabel]

    public init(labels: [KSuiteLabel]) {
        self.labels = labels
    }

    public var body: some View {
        VStack(spacing: IKPadding.huge) {
            KSuiteResources.background.swiftUIImage
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: IKPadding.huge) {
                VStack(alignment: .leading, spacing: IKPadding.medium) {
                    Text("Passer à la vitesse supérieur avec l'offre standard")
                        .multilineTextAlignment(.center)
                        .font(FontHelper.title)
                        .foregroundStyle(ColorHelper.primary)
                        .frame(maxWidth: .infinity, alignment: .center)

                    Text("Donnez à votre équipe les outils essentiels pour collaborer efficacement au quotidien.")
                }

                VStack(alignment: .leading, spacing: IKPadding.medium) {
                    ForEach(labels) { label in
                        Label {
                            Text(label.text)
                        } icon: {
                            label.icon
                                .iconSize(.large)
                        }
                    }
                }

                Text("Pour faire évoluer votre offre, utilisez l'interface web.")

                Button {
                    dismiss()
                } label: {
                    Text("Fermer")
                        .foregroundStyle(ColorHelper.primary)
                }
                .ikButtonFullWidth(true)
                .controlSize(.large)
                .tint(ColorHelper.reversedPrimary)
                .buttonStyle(.ikBorderedProminent)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.horizontal, value: .large)
            .font(FontHelper.body)
            .foregroundStyle(ColorHelper.secondary)
        }
        .padding(.bottom, 24)
        .background(ColorHelper.backgroundPrimary)
        
    }
}

#Preview {
    KSuiteView(labels: [])
}
