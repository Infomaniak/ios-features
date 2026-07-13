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

#if canImport(UIKit)
import DesignSystem
import InfomaniakCoreSwiftUI
import InfomaniakCoreUIResources
import SwiftUI

@available(iOS 16.4, *)
struct ContactCardOnBoardingView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.contactCardTheme) private var contactCardTheme

    let onCreateButtonTapped: () -> Void

    let itemsStrings: [String] = [
        Localizable.contactCardOnBoardingFirstItem,
        Localizable.contactCardOnBoardingSecondItem,
        Localizable.contactCardOnBoardingThirdItem
    ]

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Image(.backgroundOnboarding)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height / 2)
                    .allowsHitTesting(false)
                    .foregroundStyle(contactCardTheme.navBarBackground)

                VStack {
                    OnboardingHeaderView()
                        .padding(IKPadding.medium)
                        .frame(maxWidth: 300)
                        .environment(\.contactCardTheme, contactCardTheme)
                        .padding(.top, IKPadding.giant)

                    Text(Localizable.contactCardOnBoardingDescription)
                        .multilineTextAlignment(.center)
                        .font(.Custom.body)
                        .foregroundStyle(contactCardTheme.secondaryText)
                        .padding(.vertical, IKPadding.medium)
                        .padding(.horizontal, IKPadding.large)

                    VStack(spacing: IKPadding.mini) {
                        ForEach(itemsStrings, id: \.self) { itemString in
                            FeatureItemCell(
                                text: itemString
                            )
                            .padding(.horizontal, IKPadding.large)
                        }
                    }
                }
                .frame(maxWidth: 600)
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(minHeight: UIScreen.main.bounds.height - 150, alignment: .center)
            }
        }
        .ignoresSafeArea(.all)
        .scrollBounceBehavior(.basedOnSize)
        .safeAreaInset(edge: .bottom) {
            Button(Localizable.buttonCreate) {
                onCreateButtonTapped()
            }
            .buttonStyle(.ikBorderedProminent)
            .ikButtonFullWidth(true)
            .controlSize(.large)
            .ikButtonTheme(
                IKButtonTheme(
                    primary: contactCardTheme.primary,
                    secondary: contactCardTheme.secondary,
                    tertiary: Color.gray,
                    disabledPrimary: Color.gray,
                    disabledSecondary: Color.white,
                    error: Color.red,
                    smallFont: .body,
                    mediumFont: .headline
                )
            )
            .padding(.horizontal, IKPadding.large)
            .padding(.bottom, IKPadding.mini)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: dismiss.callAsFunction) {
                    Label(CoreUILocalizable.buttonClose, systemImage: "xmark")
                }
            }
        }
        .background(contactCardTheme.background)
        .matomoView(view: ["ContactCardOnboardingView"])
    }
}

@available(iOS 16.4, *)
#Preview {
    ContactCardOnBoardingView {}
}
#endif
