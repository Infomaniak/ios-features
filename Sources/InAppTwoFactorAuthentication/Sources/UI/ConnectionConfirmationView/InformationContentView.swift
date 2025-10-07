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
import SwiftUI

struct InformationAction {
    let title: String
    let action: () -> Void
}

struct InformationContentView: View {
    @Environment(\.dismiss) private var dismiss

    let text: String
    var additionalAction: InformationAction?

    var body: some View {
        VStack {
            Text(text)
                .multilineTextAlignment(.center)
                .font(.Custom.body)
                .foregroundStyle(Color.Custom.textSecondary)

            VStack(spacing: IKPadding.small) {
                if let additionalAction {
                    Button(additionalAction.title, action: additionalAction.action)
                        .buttonStyle(.ikBorderedProminent)
                        .ikButtonFullWidth(true)
                        .controlSize(.large)
                }

                Button("!Close", action: dismiss.callAsFunction)
                    .buttonStyle(.ikBordered)
                    .ikButtonFullWidth(true)
                    .controlSize(.large)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .padding(IKPadding.large)
    }
}

#Preview {
    InformationContentView(text: "An error occurred", additionalAction: InformationAction(title: "Retry") {})
}
