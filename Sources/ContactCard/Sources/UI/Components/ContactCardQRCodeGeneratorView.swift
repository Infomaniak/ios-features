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
import InfomaniakCore
import QRCode
import SwiftUI
import UIKit

struct ContactCardQRCodeGeneratorView: View {
    @Environment(\.contactCardTheme) private var contactCardTheme

    @State private var generatedDocument: QRCode.Document?
    @State private var isShowingError = false

    let userProfile: UserProfile

    let contactCard: ContactCard

    var body: some View {
        Group {
            if let generatedDocument {
                QRCodeDocumentUIViewWrapper(document: generatedDocument)
            } else if isShowingError {
                VStack(spacing: IKPadding.small) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.title)
                    Text(Localizable.qrCodeGenerationError)
                        .font(.headline)
                }
                .foregroundStyle(Color.red)
            } else {
                ProgressView()
            }
        }
        .task {
            await computeQRCode()
        }
        .onChange(of: contactCardTheme.primary) { newPrimary in
            Task { await computeQRCode(foregroundColor: UIColor(newPrimary).cgColor) }
        }
    }

    @MainActor private func computeQRCode(foregroundColor: CGColor? = nil) async {
        let fg = foregroundColor ?? UIColor(.black).cgColor
        let bg = UIColor(.white).cgColor

        do {
            var documentBuilder = try QRCode.build
                .text(contactCard.makeVCardString(forQRCode: true))
                .errorCorrection(.high)
                .foregroundColor(fg)
                .backgroundColor(bg)

            if let avatarString = userProfile.avatar,
               let avatarURL = URL(string: avatarString),
               let (data, _) = try? await URLSession.shared.data(from: avatarURL),
               let uiImage = UIImage(data: data),
               let cgImage = makeCircularImage(uiImage).cgImage {
                let template = QRCode.LogoTemplate(
                    image: cgImage,
                    path: CGPath(ellipseIn: CGRect(x: 0.35, y: 0.35, width: 0.30, height: 0.30), transform: nil),
                    inset: 3
                )

                documentBuilder = documentBuilder.logo(template)
            }

            generatedDocument = documentBuilder.document
        } catch {
            generatedDocument = nil
            isShowingError = true
        }
    }

    private func makeCircularImage(_ image: UIImage) -> UIImage {
        let size = CGSize(width: 120, height: 120)
        return UIGraphicsImageRenderer(size: size).image { _ in
            let rect = CGRect(origin: .zero, size: size)
            UIBezierPath(ovalIn: rect).addClip()
            image.draw(in: rect)
        }
    }
}

private struct QRCodeDocumentUIViewWrapper: UIViewRepresentable {
    let document: QRCode.Document

    func makeUIView(context: Context) -> QRCodeDocumentView {
        QRCodeDocumentView(document: document)
    }

    func updateUIView(_ uiView: QRCodeDocumentView, context: Context) {
        uiView.document = document
        uiView.setNeedsDisplay()
    }
}
#endif
