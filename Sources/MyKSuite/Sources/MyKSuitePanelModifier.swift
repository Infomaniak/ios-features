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

import InfomaniakCoreSwiftUI
import SwiftUI

struct MyKSuitePanelModifier: ViewModifier {
    @Binding var isPresented: Bool
    let backgroundColor: Color
    let configuration: MyKSuiteConfiguration

    func body(content: Content) -> some View {
        content
            .floatingPanel(isPresented: $isPresented,
                           closeButtonHidden: true,
                           backgroundColor: backgroundColor) {
                MyKSuiteView(configuration: configuration)
            }
    }
}

public extension View {
    func myKSuitePanel(isPresented: Binding<Bool>, backgroundColor: Color, configuration: MyKSuiteConfiguration) -> some View {
        modifier(MyKSuitePanelModifier(isPresented: isPresented, backgroundColor: backgroundColor, configuration: configuration))
    }
}

#Preview {
    Text("Hello world!")
        .myKSuitePanel(isPresented: .constant(true), backgroundColor: .white, configuration: .kDrive)
}
