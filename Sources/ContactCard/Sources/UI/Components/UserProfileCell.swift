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
import SwiftUI

struct UserProfileCell: View {
    @Environment(\.contactCardTheme) private var contactCardTheme

    let contactCard: ContactCard

    private static let maxVisibleSocialIcons = 4

    private var infoRows: [(label: String, value: String)] {
        var rows: [(String, String)] = []
        if let company = contactCard.company, !company.isEmpty {
            rows.append((Localizable.company, company))
        }
        if !contactCard.phone.isEmpty {
            rows.append((Localizable.phone, contactCard.phone))
        }
        if let website = contactCard.links?.first(where: { $0.type == .website }) {
            rows.append((Localizable.webSite, website.url))
        }
        return rows
    }

    private var socialLinks: [ContactCardLink] {
        contactCard.links?.filter { $0.type != .website } ?? []
    }

    var body: some View {
        VStack(spacing: IKPadding.medium) {
            VStack(spacing: IKPadding.micro) {
                Text("\(contactCard.firstName) \(contactCard.lastName)")
                    .font(.Custom.title1)
                    .foregroundStyle(contactCardTheme.primaryText)
                    .multilineTextAlignment(.center)
                Text(contactCard.email)
                    .font(.Custom.headline)
                    .foregroundStyle(contactCardTheme.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(IKPadding.medium)

            if !infoRows.isEmpty {
                VStack(spacing: IKPadding.mini) {
                    ForEach(infoRows, id: \.label) { row in
                        ContactInfoRow(label: row.label, value: row.value, valueColor: contactCardTheme.primary)
                        Divider()
                    }
                }
            }

            if !socialLinks.isEmpty {
                SocialLinksRow(links: socialLinks, maxVisible: Self.maxVisibleSocialIcons, color: contactCardTheme.primary)
            }
        }
    }
}

private struct ContactInfoRow: View {
    let label: String
    let value: String
    let valueColor: Color

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(label)
                .foregroundStyle(valueColor)
            Spacer()
            Text(value)
                .foregroundStyle(valueColor)
                .lineLimit(1)
                .truncationMode(.tail)
        }
        .font(.subheadline)
    }
}

private struct SocialLinksRow: View {
    let links: [ContactCardLink]
    let maxVisible: Int
    let color: Color

    private var visibleLinks: [ContactCardLink] {
        Array(links.prefix(maxVisible))
    }

    private var overflow: Int {
        max(0, links.count - maxVisible)
    }

    var body: some View {
        HStack(spacing: IKPadding.small) {
            ForEach(visibleLinks, id: \.url) { link in
                link.type.systemImageName
                    .foregroundStyle(color)
                    .font(.Custom.headline)
            }
            if overflow > 0 {
                Text("+\(overflow)")
                    .font(.subheadline.bold())
                    .foregroundStyle(color)
            }
            Spacer()
        }
    }
}

extension ContactCardType {
    var systemImageName: Image {
        switch self {
        case .linkedIn: return Image(.linkedin)
        case .instagram: return Image(.intagram)
        case .facebook: return Image(.facebook)
        case .x: return Image(.link)
        case .website: return Image(.link)
        case .other: return Image(.link)
        }
    }
}

#Preview {
    UserProfileCell(contactCard: ProfileFake.fakeContactCard)
        .padding()
}
