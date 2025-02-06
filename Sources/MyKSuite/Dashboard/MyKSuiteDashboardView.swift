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
@preconcurrency import InfomaniakCore
import InfomaniakCoreSwiftUI
import InfomaniakDI
import OSLog
import SwiftUI

public struct MyKSuiteDashboardView: View {
    @InjectService var myKSuiteStore: MyKSuiteStore
    @Environment(\.dismiss) private var dismiss

    @State private var myKSuite: MyKSuite?
    private let apiFetcher: ApiFetcher
    private let userId: Int
    private let avatar: Image?

    public init(apiFetcher: ApiFetcher, userId: Int, userAvatar: Image?) {
        self.apiFetcher = apiFetcher
        self.userId = userId
        avatar = userAvatar
    }

    public var body: some View {
        NavigationView {
            if let myKSuite {
                VStack(spacing: IKPadding.large) {
                    SubscriptionCardView(myKSuite: myKSuite, avatar: avatar)

                    if !myKSuite.isFree {
                        SubscriptionBenefitsView()
                    }
                }
                .padding(value: .medium)
                .navigationTitle(Text("myKSuiteDashboardTitle", bundle: .module))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(role: .destructive) {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .background {
                    ImageHelper.background
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: .infinity, alignment: .top)
                        .ignoresSafeArea()
                }
            }
        }
        .task {
            do {
                myKSuite = try await myKSuiteStore.updateMyKSuite(with: self.apiFetcher, id: userId)
            } catch {
                Logger.general.error("Error fetching my ksuite: \(error)")
            }
        }
    }
}

// #Preview {
//    MyKSuiteDashboardView(apiFetcher: ApiFetcher())
// }
