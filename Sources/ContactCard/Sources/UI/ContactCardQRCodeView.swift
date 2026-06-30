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
import InfomaniakCore
import InfomaniakCoreSwiftUI
import Nuke
import NukeUI
import SwiftUI
import UniformTypeIdentifiers

private struct VCardTransferable: Transferable {
    let contactCard: ContactCard

    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(exportedContentType: .vCard) { item in
            let photoData = await item.getCacheAvatarData()
            return Data(item.contactCard.makeVCardString(photoData: photoData).utf8)
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

    @Binding var path: NavigationPath
    @State private var showDeleteConfirmation = false

    let userProfile: UserProfile
    let contactCard: ContactCard
    let rootPath: URL
    let onDelete: (() -> Void)?
    let onUpdate: ((ContactCard) -> Void)?

    var body: some View {
        VStack {
            ContactCardQRCodeGeneratorView(userProfile: userProfile, contactCard: contactCard)
                .frame(width: 250, height: 250)
                .padding(IKPadding.large)
                .background(contactCardTheme.onAccent, in: .rect(cornerRadius: IKRadius.large))
                .overlay(
                    QRFrameShape(cornerLength: 250 / 8)
                        .stroke(
                            contactCardTheme.primary,
                            style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round)
                        )
                )
                .padding(.bottom, IKPadding.huge)

            UserProfileCell(contactCard: contactCard)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, IKPadding.huge)
        .safeAreaInset(edge: .bottom, content: {
            ShareLink(
                item: VCardTransferable(contactCard: contactCard),
                preview: SharePreview(
                    "\(contactCard.firstName) \(contactCard.lastName)",
                    image: Image(systemName: "person.crop.circle")
                )
            ) {
                Label(MyString.qrCodeShared, systemImage: MyString.qrCodeSharedImage)
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
        .navigationBarBackButtonHidden(true)
        .alert(MyString.qrCodeDeleteAlertTitle, isPresented: $showDeleteConfirmation) {
            Button(MyString.qrCodeDeleteAlertConfirm, role: .destructive) {
                Task {
                    await ContactCardManager(rootPath: rootPath).delete(userId: userProfile.id)
                    path = NavigationPath()
                    onDelete?()
                }
            }
            Button(MyString.qrCodeDeleteAlertCancel, role: .cancel) {}
        } message: {
            Text(MyString.qrCodeDeleteAlertMessage)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button {
                        path.append(ContactCardRoute.form(userProfile, rootPath, contactCard))
                    } label: {
                        Label(MyString.qrCodeMenuEdit, systemImage: "pencil")
                    }

                    Button(role: .destructive) {
                        showDeleteConfirmation = true
                    } label: {
                        Label(MyString.qrCodeMenuDelete, systemImage: "trash")
                    }
                } label: {
                    Label("More", systemImage: "ellipsis")
                }
            }

            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    path = NavigationPath()
                } label: {
                    Label("Back", systemImage: "chevron.left")
                }
            }
        }
        .toolbarBackground(contactCardTheme.secondary.opacity(0.5), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct ContactCardQRCodeViewPreview: View {
    @State var path = NavigationPath()

    var body: some View {
        ContactCardQRCodeView(
            path: $path,
            userProfile: ProfileFake.fakeUserProfile,
            contactCard: ProfileFake.fakeContactCard,
            rootPath: FileManager.default.temporaryDirectory,
            onDelete: nil,
            onUpdate: nil
        )
    }
}

#Preview {
    ContactCardQRCodeViewPreview()
}
