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
import InfomaniakCore
import QRCode
import SwiftUI

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
                    Text(MyString.qrCodeGenerationError)
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

    private func computeQRCode(foregroundColor: CGColor? = nil) async {
        let fg = foregroundColor ?? UIColor(contactCardTheme.primary).cgColor
        let bg = UIColor(contactCardTheme.onAccent).cgColor
        let doc = QRCode.Document(utf8String: contactCard.makeVCardString(), errorCorrection: .high)
        doc.design.foregroundColor(fg)
        doc.design.backgroundColor(bg)

        // TODO: Add true infomaniak logo
        if let cgImage = renderSFSymbol("k.square.fill", color: UIColor(contactCardTheme.primary), size: 100) {
            doc.logoTemplate = QRCode.LogoTemplate(
                image: cgImage,
                path: CGPath(rect: CGRect(x: 0.35, y: 0.35, width: 0.30, height: 0.30), transform: nil),
                inset: 3
            )
        }

        generatedDocument = doc
    }

    private func renderSFSymbol(_ name: String, color: UIColor, size: CGFloat) -> CGImage? {
        guard let symbol = UIImage(systemName: name)?
            .withTintColor(color, renderingMode: .alwaysOriginal) else { return nil }
        let bounds = CGSize(width: size, height: size)
        return UIGraphicsImageRenderer(size: bounds).image { _ in
            symbol.draw(in: CGRect(origin: .zero, size: bounds))
        }.cgImage
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
