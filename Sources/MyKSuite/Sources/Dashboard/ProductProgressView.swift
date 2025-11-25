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
import KSuiteUtils
import SwiftUI

struct ProductProgressView: View {
    @Environment(\.colorScheme) private var colorScheme
    let product: Product
    let usedValue: Int64
    let totalValue: Int64

    var body: some View {
        VStack(spacing: IKPadding.mini) {
            HStack {
                Text(product.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(ColorHelper.primary)
                    .font(FontHelper.body)

                Text("\(usedValue.formatted(.defaultByteCount)) / \(totalValue.formatted(.defaultByteCount))")
                    .foregroundStyle(ColorHelper.secondary)
                    .font(FontHelper.bodySmall)
            }

            ProgressView(value: Double(usedValue), total: Double(totalValue))
                .progressViewStyle(CustomProgressBar())
                .foregroundStyle(product.color)
        }
    }
}

#Preview {
    ProductProgressView(product: .mail, usedValue: 2300, totalValue: 20)
}
