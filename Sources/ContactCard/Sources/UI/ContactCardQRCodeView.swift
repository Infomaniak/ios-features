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
import Foundation
import InfomaniakCore
import InfomaniakCoreCommonUI
import InfomaniakCoreUIResources
import InfomaniakDI
import SwiftUI

@available(iOS 16.4, *)
struct ContactCardQRCodeView: View {
    @Environment(\.contactCardTheme) private var contactCardTheme
    @Environment(\.dismiss) private var dismiss
    @Environment(\.scenePhase) private var scenePhase

    @State private var isShowingDeleteConfirmation = false
    @State private var savedBrightness: CGFloat = UIScreen.main.brightness

    @Binding var path: [ContactCardRoute]

    let userProfile: UserProfile
    let contactCard: ContactCard
    let rootPath: URL
    let dismissModal: (() -> Void)?

    var body: some View {
        ScrollView {
            CardContentView(userProfile: userProfile, contactCard: contactCard)
        }
        .onAppear {
            savedBrightness = UIScreen.main.brightness
            UIScreen.main.brightness = 1.0
        }
        .onDisappear {
            UIScreen.main.brightness = savedBrightness
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .background {
                UIScreen.main.brightness = savedBrightness
            } else if newPhase == .active {
                UIScreen.main.brightness = 1.0
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .bottom) { ShareButton(contactCard: contactCard) }
        .navigationBarBackButtonHidden(true)
        .alert(Localizable.deleteAlertTitle, isPresented: $isShowingDeleteConfirmation) {
            Button(Localizable.deleteButton, role: .destructive) {
                Task {
                    try? await ContactCardManager(rootPath: rootPath).deleteCardFor(userId: userProfile.id)
                    dismissModal?()
                }

                @InjectService var matomo: MatomoUtils
                matomo.track(eventWithCategory: .contactCard, name: "delete")
            }
            Button(CoreUILocalizable.buttonCancel, role: .cancel) {}
        } message: {
            Text(Localizable.deleteAlertDescription)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button {
                        withAnimation {
                            path.append(ContactCardRoute.form(userProfile, contactCard))
                        }
                    } label: {
                        Label(Localizable.menuEdit, systemImage: "pencil")
                    }

                    Button(role: .destructive) {
                        isShowingDeleteConfirmation = true
                    } label: {
                        Label(Localizable.deleteButton, systemImage: "trash")
                    }
                } label: {
                    Label(Localizable.buttonMore, systemImage: "ellipsis")
                }
            }

            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismissModal?()
                } label: {
                    Label(CoreUILocalizable.buttonClose, systemImage: "xmark")
                }
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .background(contactCardTheme.navBarBackground)
        .matomoView(view: ["ContactCardQRCodeView"])
    }
}
#endif
