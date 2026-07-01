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

import DesignSystem
import Foundation
import InfomaniakCoreSwiftUI
import SwiftUI

@available(iOS 16.4, *)
struct ContactCardOnBoardingView: View {
    @Environment(\.contactCardTheme) private var contactCardTheme

    let onCreateButtonTapped: () -> Void

    var body: some View {
        ZStack(alignment: .top) {
            Image(.backgroundOnboarding)
                .resizable()
                .scaledToFit()
                .scaleEffect(x: -1, y: 1.25)
                .frame(maxWidth: .infinity)
                .allowsHitTesting(false)
                .foregroundStyle(contactCardTheme.secondary).opacity(0.5)

            ScrollView {
                VStack {
                    Color.clear
                        .frame(height: 75)

                    OnBoardingHeaderView()
                        .environment(\.contactCardTheme, contactCardTheme)
                        .padding(.top, IKPadding.giant)

                    Text(MyString.contactCardOnBaoardingDescription)
                        .multilineTextAlignment(.center)
                        .font(.Custom.body)
                        .foregroundStyle(contactCardTheme.secondaryText)
                        .padding(.vertical, IKPadding.medium)
                        .padding(.horizontal, IKPadding.large)

                    VStack(spacing: IKPadding.mini) {
                        let myStrings = [
                            MyString.contactCardOnBaoardingFirstItem,
                            MyString.contactCardOnBaoardingSecondItem,
                            MyString.contactCardOnBaoardingThirdItem
                        ]
                        
                        ForEach(myStrings, id: \.self) { itemString in
                            FeatureItemCell(
                                text: itemString
                            )
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, IKPadding.large)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(IKPadding.medium)
            }
        }
        .ignoresSafeArea(.all)
        .scrollBounceBehavior(.basedOnSize)
        .safeAreaInset(edge: .bottom, content: {
            Button(MyString.contactCardOnBaoardingCreate) {
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
        })
        .background(contactCardTheme.background)
    }
}

@available(iOS 16.4, *)
#Preview {
    ContactCardOnBoardingView(onCreateButtonTapped: {})
}
