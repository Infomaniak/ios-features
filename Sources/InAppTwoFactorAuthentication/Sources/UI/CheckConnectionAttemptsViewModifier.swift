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

import InfomaniakCore
import InfomaniakDI
import SwiftUI

public extension View {
    func checkConnectionAttempts(using sessions: [InAppTwoFactorAuthenticationSession]) -> some View {
        modifier(CheckConnectionAttemptsViewModifier(sessions: sessions))
    }
}

struct CheckConnectionAttemptsViewModifier: ViewModifier {
    let sessions: [InAppTwoFactorAuthenticationSession]

    func body(content: Content) -> some View {
        content
            .sceneLifecycle(willEnterForeground: fetchPendingConnectionAttempts)
    }

    func fetchPendingConnectionAttempts() {
        @InjectService var twoFactorAuthenticationManager: InAppTwoFactorAuthenticationManagerable
        twoFactorAuthenticationManager.checkConnectionAttempts(using: sessions)
    }
}

@available(iOS 17.0, *)
#Preview {
    @Previewable @State var assembly = PreviewTargetAssembly()
    Text("Some app")
        .checkConnectionAttempts(using: [InAppTwoFactorAuthenticationSession.preview])
}
