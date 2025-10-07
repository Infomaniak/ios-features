/*
 iOS Features
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

import SwiftUI

struct TimeAgoView: View {
    let challengeCreatedAt: Date

    var body: some View {
        TimelineView(.periodic(from: challengeCreatedAt, by: 60)) { context in
            Text(text(for: context.date))
        }
    }

    func text(for date: Date) -> String {
        let secondsAgo = Int(date.timeIntervalSince(challengeCreatedAt))

        if secondsAgo >= 60 {
            return Localizable.twoFactorAuthMinutesAgoLabel(secondsAgo / 60)
        } else {
            return Localizable.twoFactorAuthJustNowLabel
        }
    }
}

#Preview {
    TimeAgoView(challengeCreatedAt: Date())
}
