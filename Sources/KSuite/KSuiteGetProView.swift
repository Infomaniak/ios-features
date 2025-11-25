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
