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

import SwiftUI

struct ProductProgressView: View {
    @Environment(\.colorScheme) private var colorScheme
    let product: Product
    let usedValue: Int64
    let totalValue: Int64

    var body: some View {
        VStack {
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
