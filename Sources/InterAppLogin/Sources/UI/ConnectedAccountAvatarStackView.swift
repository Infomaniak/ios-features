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

import SwiftUI

private struct FewAvatarsAnimationView: View {
    let accounts: [ConnectedAccount]
    let size: CGFloat

    var body: some View {
        HStack(spacing: -size * 0.4) {
            ForEach(accounts.indices, id: \.self) { index in
                ConnectedAccountAvatarView(connectedAccount: accounts[index], size: size)
            }
        }
    }
}

private struct ManyAvatarsAnimationView: View {
    @State private var currentIndex = 0

    let accounts: [ConnectedAccount]
    let size: CGFloat
    let maxStackSize: Int

    init(
        accounts: [ConnectedAccount],
        size: CGFloat = ConnectedAccountAvatarStackView.defaultSize,
        maxStackSize: Int = ConnectedAccountAvatarStackView.defaultMaxStackSize
    ) {
        self.accounts = accounts
        self.size = size
        self.maxStackSize = maxStackSize
    }

    var body: some View {
        ZStack {
            ForEach(accounts.indices, id: \.self) { index in
                ConnectedAccountAvatarView(connectedAccount: accounts[index], size: size)
                    .offset(x: offsetForIndex(index))
                    .scaleEffect(scaleForIndex(index), anchor: .center)
                    .zIndex(normalizedIndex(index) == 1 ? 1 : 0)
                    .animation(Animation.spring(duration: 0.5), value: currentIndex)
                    .opacity(normalizedIndex(index) >= maxStackSize ? 0 : 1)
            }
        }
        .task {
            while !Task.isCancelled && accounts.count > 1 {
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                currentIndex = (currentIndex + 1) % accounts.count
            }
        }
    }

    func normalizedIndex(_ index: Int) -> Int {
        let count = accounts.count
        return (index - currentIndex % count + count) % count
    }

    func scaleForIndex(_ index: Int) -> CGFloat {
        guard accounts.count > 1 else {
            return 1.0
        }

        return normalizedIndex(index) == 1 ? 1.0 : 0.75
    }

    func offsetForIndex(_ index: Int) -> CGFloat {
        guard accounts.count > 1 else {
            return 0
        }

        let normalizedIndex = normalizedIndex(index)
        return (CGFloat(normalizedIndex) * size * 0.6) - size * 0.6
    }
}

struct ConnectedAccountAvatarStackView: View {
    static let defaultSize: CGFloat = 32
    static let defaultMaxStackSize = 3

    let accounts: [ConnectedAccount]
    let size: CGFloat
    let maxStackSize: Int

    init(
        accounts: [ConnectedAccount],
        size: CGFloat = ConnectedAccountAvatarStackView.defaultSize,
        maxStackSize: Int = ConnectedAccountAvatarStackView.defaultMaxStackSize
    ) {
        self.accounts = accounts
        self.size = size
        self.maxStackSize = maxStackSize
    }

    var body: some View {
        Group {
            if accounts.count <= 2 {
                FewAvatarsAnimationView(accounts: accounts, size: size)
            } else {
                ManyAvatarsAnimationView(accounts: accounts, size: size)
            }
        }
        .frame(width: 0.6 * size * CGFloat(min(maxStackSize, accounts.count)))
    }
}

#Preview {
    VStack {
        ConnectedAccountAvatarStackView(
            accounts: [PreviewHelper.connectedAccount]
        )
        ConnectedAccountAvatarStackView(
            accounts: Array(PreviewHelper.allAccounts.dropFirst())
        )
        ConnectedAccountAvatarStackView(
            accounts: PreviewHelper.allAccounts
        )
        ConnectedAccountAvatarStackView(
            accounts: (PreviewHelper.allAccounts + PreviewHelper.allAccounts).shuffled()
        )
    }
}
