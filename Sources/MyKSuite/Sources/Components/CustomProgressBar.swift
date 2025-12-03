/*
 Infomaniak Features - iOS
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

import KSuiteUtils
import SwiftUI

struct CustomProgressBar: ProgressViewStyle {
    let barHeight: CGFloat = 14

    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: barHeight / 2)
                .frame(height: barHeight)
                .foregroundStyle(ColorHelper.reversedPrimary)
                .overlay {
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: barHeight / 2)
                            .frame(
                                width: filledProgressBarWidth(
                                    progressBarWidth: geometry.size.width,
                                    fractionCompleted: configuration.fractionCompleted ?? 0
                                ),
                                height: barHeight
                            )
                    }
                }
        }
    }

    func filledProgressBarWidth(progressBarWidth: CGFloat, fractionCompleted: CGFloat) -> CGFloat {
        max(barHeight, progressBarWidth * CGFloat(fractionCompleted))
    }
}

#Preview {
    VStack {
        ProgressView(value: 2.3, total: 15)
            .progressViewStyle(CustomProgressBar())
            .foregroundStyle(.blue)
        ProgressView(value: 1, total: 1000)
            .progressViewStyle(CustomProgressBar())
            .foregroundStyle(.blue)
    }
    .padding()
}
