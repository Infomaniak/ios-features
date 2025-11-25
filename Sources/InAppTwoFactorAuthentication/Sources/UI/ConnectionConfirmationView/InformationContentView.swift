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
import InfomaniakCoreUIResources
import SwiftUI

struct InformationAction {
    let title: String
    let action: () -> Void
}

struct InformationContentView: View {
    let text: String
    var additionalAction: InformationAction?
    let onClose: () -> Void

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

                Button(CoreUILocalizable.buttonClose, action: onClose)
                    .buttonStyle(.ikBordered)
                    .ikButtonFullWidth(true)
                    .controlSize(.large)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .padding(.horizontal, value: .large)
    }
}

#Preview {
    InformationContentView(text: "An error occurred", additionalAction: InformationAction(title: "Retry") {}) {}
}
