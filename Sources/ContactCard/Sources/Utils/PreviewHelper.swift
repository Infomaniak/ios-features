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

import Foundation
import InfomaniakCore

enum ProfileFake {
    static let fakeUserProfile = UserProfile(
        id: 42,
        displayName: "Camille Mercier",
        firstName: "Camille",
        lastName: "Mercier",
        email: "camille.mercier@example.com",
        avatar: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=512&h=512&fit=crop"
    )

    static let fakeContactCardsLinks: [ContactCardLink] = [
        .init(type: .website, url: "https://joe.doe.fr"),
        .init(type: .linkedIn, url: "https://linkedin.com/in/joe.doe"),
        .init(type: .facebook, url: "https://facebook.com/in/joe.doe"),
        .init(type: .instagram, url: "https://instagram.com/in/joe.doe"),
        .init(type: .x, url: "https://x.com/in/joe.doe"),
        .init(type: .other, url: "https://other1.com/in/joe.doe"),
        .init(type: .other, url: "https://other2.com/in/joe.doe")
    ]

    static let fakeContactCard = ContactCard(
        id: 43,
        firstName: "Joe",
        lastName: "Doe",
        email: "joe.doe@example.com",
        phone: "+44 777 123 456",
        company: "Infomaniak",
        links: fakeContactCardsLinks
    )
}
