//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.

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
