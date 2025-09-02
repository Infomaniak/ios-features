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

import InfomaniakCoreSwiftUI
import SwiftUI

struct KSuitePanelModifier: ViewModifier {
    @Binding var isPresented: Bool
    let backgroundColor: Color
    let configuration: KSuiteConfiguration
    let isAdmin: Bool

    func body(content: Content) -> some View {
        content
            .floatingPanel(isPresented: $isPresented, closeButtonHidden: true, backgroundColor: backgroundColor, topPadding: 0) {
                KSuiteView(configuration: configuration, isAdmin: isAdmin)
            }
    }
}

public extension View {
    func kSuitePanel(
        isPresented: Binding<Bool>,
        backgroundColor: Color = .clear,
        configuration: KSuiteConfiguration,
        isAdmin: Bool
    ) -> some View {
        modifier(KSuitePanelModifier(
            isPresented: isPresented,
            backgroundColor: backgroundColor,
            configuration: configuration,
            isAdmin: isAdmin
        ))
    }
}

#Preview {
    Text("Hello world!")
        .kSuitePanel(isPresented: .constant(true), configuration: .business, isAdmin: true)
}
