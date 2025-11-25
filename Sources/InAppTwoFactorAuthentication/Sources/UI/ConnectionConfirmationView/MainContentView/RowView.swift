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
import SwiftUI

struct RowView<Content: View>: View {
    let title: String
    @ViewBuilder let description: Content

    var body: some View {
        VStack(alignment: .leading, spacing: IKPadding.micro) {
            Text(title)
                .font(.Custom.callout)
                .foregroundStyle(Color.Custom.textSecondary)
            description
                .font(.Custom.headline)
                .foregroundStyle(Color.Custom.textPrimary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension RowView where Content == Text {
    init(title: String, description: String) {
        self.title = title
        self.description = Text(description)
    }
}

#Preview {
    VStack {
        RowView(title: "Device") {
            HStack {
                Text("iPhone 17")
                Image(systemName: "iphone.gen2")
            }
        }
        RowView(title: "Place", description: "Switzerland")
    }
}
