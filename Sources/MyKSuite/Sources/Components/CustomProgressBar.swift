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
