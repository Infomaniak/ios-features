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
import Foundation
import InfomaniakCore
import InfomaniakCoreSwiftUI
import InfomaniakCoreUIResources
import Nuke
import NukeUI
import SwiftUI
import UniformTypeIdentifiers

private struct VCardTransferable: Transferable {
    let contactCard: ContactCard

    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(exportedContentType: .vCard) { item in
            let photoData = await item.getCacheAvatarData()
            return await Data(item.contactCard.makeVCardString(photoData: photoData).utf8)
        }
    }

    private func getCacheAvatarData() async -> PlatformImage? {
        guard let urlString = contactCard.avatarURL,
              let url = URL(string: urlString) else { return nil }
        return try? await ImagePipeline.shared.image(for: url)
    }
}

struct ContactCardQRCodeView: View {
    @Environment(\.contactCardTheme) private var contactCardTheme
    @Environment(\.dismiss) private var dismiss
    @Environment(\.scenePhase) private var scenePhase

    @Binding var myState: StateCardView

    @State private var showDeleteConfirmation = false
    @State private var savedBrightness: CGFloat = UIScreen.main.brightness

    let userProfile: UserProfile
    let contactCard: ContactCard
    let rootPath: URL
    let onDelete: (() -> Void)?
    let onUpdate: ((ContactCard) -> Void)?

    var body: some View {
        ScrollView {
            cardContent
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
        .safeAreaInset(edge: .bottom) { shareButton }
        .navigationBarBackButtonHidden(true)
        .alert(Localizable.deleteAlertTitle, isPresented: $showDeleteConfirmation) {
            Button(Localizable.deleteButton, role: .destructive) {
                Task {
                    try? await ContactCardManager(rootPath: rootPath).delete(userId: userProfile.id)
                    dismiss()
                    onDelete?()
                }
            }
            Button(CoreUILocalizable.buttonCancel, role: .cancel) {}
        } message: {
            Text(Localizable.deleteAlertDescription)
        }
        .toolbar {
            trailingToolbarItem
            leadingToolbarItem
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .background(contactCardTheme.navBarBackground)
    }

    var cardContent: some View {
        VStack(spacing: 0) {
            qrCodeSection
            userProfileSection
        }
        .background(contactCardTheme.background)
        .clipShape(RoundedRectangle(cornerRadius: IKRadius.large))
        .padding(IKPadding.medium)
        .padding(.bottom, IKPadding.large)
        .frame(maxWidth: 400)
    }

    private var qrCodeSection: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundStyle(contactCardTheme.primary)
                .frame(width: .infinity, height: 80)

            ContactCardQRCodeGeneratorView(userProfile: userProfile, contactCard: contactCard)
                .environment(\.contactCardTheme, contactCardTheme)
                .frame(width: 200, height: 200)
                .padding(IKPadding.large)
                .background(contactCardTheme.background, in: RoundedRectangle(cornerRadius: IKRadius.large))
                .shadow(radius: 4, x: 0, y: 2)
                .padding(.top, IKPadding.huge)
                .padding(.bottom, IKPadding.small)
        }
        .frame(maxWidth: .infinity)
    }

    private var userProfileSection: some View {
        UserProfileCell(contactCard: contactCard)
            .padding(.horizontal, IKPadding.large)
            .padding(.bottom, IKPadding.large)
            .frame(maxWidth: .infinity)
            .background(contactCardTheme.background)
    }

    private var shareButton: some View {
        let theme = IKButtonTheme(
            primary: contactCardTheme.primary,
            secondary: contactCardTheme.secondary,
            tertiary: Color.gray,
            disabledPrimary: Color.gray,
            disabledSecondary: Color.white,
            error: Color.red,
            smallFont: .body,
            mediumFont: .headline
        )
        return ShareLink(
            item: VCardTransferable(contactCard: contactCard),
            preview: SharePreview(
                "\(contactCard.firstName) \(contactCard.lastName)"
            )
        ) {
            Text(Localizable.sharedButton)
        }
        .buttonStyle(.ikBorderedProminent)
        .ikButtonFullWidth(true)
        .controlSize(.large)
        .ikButtonTheme(theme)
        .padding(.horizontal, IKPadding.large)
        .padding(.bottom, IKPadding.mini)
    }

    private var trailingToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Menu {
                Button {
                    myState = .form(userProfile, rootPath, contactCard)
                } label: {
                    Label(Localizable.menuEdit, systemImage: "pencil")
                }

                Button(role: .destructive) {
                    showDeleteConfirmation = true
                } label: {
                    Label(Localizable.deleteButton, systemImage: "trash")
                }
            } label: {
                Label(Localizable.buttonMore, systemImage: "ellipsis")
            }
        }
    }

    private var leadingToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                dismiss()
            } label: {
                Label(CoreUILocalizable.buttonClose, systemImage: "xmark")
            }
        }
    }
}
#endif
