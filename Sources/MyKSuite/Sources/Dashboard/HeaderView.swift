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
import KSuiteUtils
import SwiftUI

struct HeaderView<Content: View>: View {
    let myKSuite: MyKSuite
    let avatarView: () -> Content

    var body: some View {
        HStack {
            ZStack {
                MyKSuiteResources.person.swiftUIImage
                    .iconSize(.medium)
                    .foregroundStyle(ColorHelper.secondary)

                avatarView()
                    .frame(width: 24, height: 24)
            }
            .frame(width: 24, height: 24)
            .overlay {
                Circle()
                    .strokeBorder(ColorHelper.gradient, lineWidth: 1)
            }
            .background(KSuiteUtilsResources.polarBear.swiftUIColor)
            .clipShape(.circle)

            Text(myKSuite.mail.email)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(ColorHelper.primary)
                .font(FontHelper.body)

            myKSuite.icon
                .padding(.horizontal, value: .mini)
                .padding(.vertical, value: .micro)
                .background(ColorHelper.reversedPrimary)
                .clipShape(Capsule())
        }
    }
}

#Preview {
    HeaderView(myKSuite: PreviewHelper.sampleMyKSuite) { EmptyView() }
}
