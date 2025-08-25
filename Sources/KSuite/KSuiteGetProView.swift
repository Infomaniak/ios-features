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

extension VerticalAlignment {
    private struct ProBadge: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context[VerticalAlignment.center] + 1
        }
    }

    static let proBadge = VerticalAlignment(ProBadge.self)
}

public struct KSuiteGetProView: View {
    public init() {}

    public var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: IKPadding.micro) {
                HStack(alignment: .proBadge, spacing: IKPadding.micro) {
                    Text(KSuiteLocalizable.kSuiteGetProTitle)
                        .font(FontHelper.bodyMedium)

                    Text(verbatim: "PRO")
                        .kerning(1)
                        .font(.system(size: 8, weight: .bold))
                        .alignmentGuide(.proBadge) { d in
                            d[VerticalAlignment.center]
                        }
                        .padding(.vertical, 2)
                        .padding(.leading, 5)
                        .padding(.trailing, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 2)
                                .strokeBorder(ColorHelper.gradient, lineWidth: 1)
                        )
                }
                .foregroundStyle(.white)

                Text(KSuiteLocalizable.kSuiteGetProDescription)
                    .font(FontHelper.bodySmall)
                    .foregroundStyle(KSuiteUtilsResources.mouse.swiftUIColor)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            KSuiteResources.chevronRight.swiftUIImage
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundStyle(KSuiteUtilsResources.swan.swiftUIColor)
        }
        .padding(value: .medium)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: IKRadius.large)
                    .foregroundStyle(KSuiteResources.menuBackgroundColor.swiftUIColor)

                RoundedRectangle(cornerRadius: IKRadius.large)
                    .strokeBorder(
                        ColorHelper.gradient,
                        lineWidth: 1
                    )
            }
        )
    }
}

#Preview {
    KSuiteGetProView()
}
