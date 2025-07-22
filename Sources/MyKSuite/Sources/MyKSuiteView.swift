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

public struct MyKSuiteView: View {
    @Environment(\.dismiss) private var dismiss

    private let configuration: MyKSuiteConfiguration

    public init(configuration: MyKSuiteConfiguration) {
        self.configuration = configuration
    }

    public var body: some View {
        VStack(spacing: IKPadding.huge) {
            MyKSuiteResources.gradient.swiftUIImage
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: IKPadding.huge) {
                VStack(alignment: .leading, spacing: IKPadding.medium) {
                    Text(MyKSuiteLocalizable.myKSuiteUpgradeTitle)
                        .font(FontHelper.title)
                        .foregroundStyle(ColorHelper.primary)
                        .frame(maxWidth: .infinity, alignment: .center)

                    Text(MyKSuiteLocalizable.myKSuiteUpgradeDescription)
                }

                VStack(alignment: .leading, spacing: IKPadding.medium) {
                    ForEach(configuration.labels) { label in
                        Label {
                            Text(label.text)
                        } icon: {
                            label.icon
                                .iconSize(.large)
                        }
                    }
                }

                Text(MyKSuiteLocalizable.myKSuiteUpgradeDetails)

                Button {
                    dismiss()
                } label: {
                    Text(MyKSuiteLocalizable.buttonClose)
                }
                .ikButtonFullWidth(true)
                .controlSize(.large)
                .buttonStyle(.ikBorderedProminent)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.horizontal, value: .large)
            .font(FontHelper.body)
            .foregroundStyle(ColorHelper.secondary)
        }
    }
}

#Preview("kDrive") {
    MyKSuiteView(configuration: .kDrive)
}

#Preview("Mail") {
    MyKSuiteView(configuration: .mail)
}
