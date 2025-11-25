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

struct CardModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme

    let withStroke: Bool

    private var strokeOpacity: Double {
        if withStroke {
            return colorScheme == .light ? 0 : 1
        }
        return 0
    }

    private var shadowOpacity: Double {
        colorScheme == .light ? 0.3 : 0
    }

    func body(content: Content) -> some View {
        content
            .clipShape(.rect(cornerRadius: IKRadius.large))
            .overlay {
                RoundedRectangle(cornerRadius: IKRadius.large)
                    .strokeBorder(KSuiteUtilsResources.elephant.swiftUIColor.opacity(strokeOpacity), lineWidth: 1)
            }
            .shadow(color: KSuiteUtilsResources.shark.swiftUIColor.opacity(shadowOpacity), radius: 10)
    }
}

extension View {
    func cardStyle(withStroke: Bool = true) -> some View {
        modifier(CardModifier(withStroke: withStroke))
    }
}
