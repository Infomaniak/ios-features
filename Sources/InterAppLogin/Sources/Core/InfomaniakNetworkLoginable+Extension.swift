/*
 Infomaniak Features - iOS
 Copyright (C) 2026 Infomaniak Network SA

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
@preconcurrency import InfomaniakCore
import InfomaniakDeviceCheck
import InfomaniakLogin

public extension InfomaniakNetworkLoginable {
    private var deviceCheckEnvironment: InfomaniakDeviceCheck.Environment {
        switch ApiEnvironment.current {
        case .prod:
            return .prod
        case .preprod:
            return .preprod
        case .customHost(let host):
            return .init(url: URL(string: "https://\(host)/1/attest")!)
        }
    }

    func derivateApiToken(for account: ConnectedAccount, appBundleId: String) async throws -> ApiToken {
        try await derivateApiToken(account.token, appBundleId: appBundleId)
    }

    func derivateApiToken(_ token: ApiToken, appBundleId: String) async throws -> ApiToken {
        let attestationToken = try await InfomaniakDeviceCheck(environment: deviceCheckEnvironment)
            .generateAttestationFor(
                targetUrl: config.loginURL.appendingPathComponent("token"),
                bundleId: appBundleId,
                bypassValidation: deviceCheckEnvironment == .preprod
            )

        return try await derivateApiToken(
            using: token,
            attestationToken: attestationToken
        )
    }
}
