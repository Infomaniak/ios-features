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
import InfomaniakCore
import InfomaniakCoreSwiftUI
import InfomaniakDI
import OSLog
import SwiftUI

public struct MyKSuiteDashboardView<Content: View>: View {
    @InjectService private var myKSuiteStore: MyKSuiteStore

    @Environment(\.dismiss) private var dismiss

    @State private var myKSuite: MyKSuite?
    private let apiFetcher: KSuiteApiFetchable
    private let userId: Int
    private let avatarView: () -> Content

    public init(apiFetcher: KSuiteApiFetchable, userId: Int, @ViewBuilder avatarView: @escaping () -> Content) {
        self.apiFetcher = apiFetcher
        self.userId = userId
        self.avatarView = avatarView
    }

    public var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: IKPadding.large) {
                    if let myKSuite {
                        SubscriptionCardView(myKSuite: myKSuite, avatarView: avatarView)

                        if !myKSuite.isFree {
                            SubscriptionBenefitsView()
                        }
                    } else {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(value: .medium)
            }
            .background(alignment: .top) {
                MyKSuiteResources.background.swiftUIImage
                    .resizable()
                    .fixedSize(horizontal: false, vertical: true)
                    .ignoresSafeArea()
            }
            .navigationTitle(MyKSuiteLocalizable.myKSuiteDashboardTitle)
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
        }
        .navigationViewStyle(.stack)
        .task {
            myKSuite = await myKSuiteStore.getMyKSuite(id: userId)
            do {
                myKSuite = try await myKSuiteStore.updateMyKSuite(with: apiFetcher, id: userId)
            } catch {
                Logger.general.error("Error fetching my ksuite: \(error)")
            }
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    @Previewable @State var di = PreviewTargetAssembly()
    MyKSuiteDashboardView(apiFetcher: PreviewKSuiteFetcher(), userId: 0) { EmptyView() }
}
