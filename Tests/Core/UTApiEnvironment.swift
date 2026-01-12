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

import InfomaniakFeatures
import Testing

@Suite("ApiEnvironment loginHost tests")
struct ApiEnvironmentLoginHostTests {
    @Test("Production environment login host")
    func productionLoginHost() {
        let environment = ApiEnvironment.prod
        #expect(environment.loginHost == "login.infomaniak.com")
    }

    @Test("Preproduction environment login host")
    func preproductionLoginHost() {
        let environment = ApiEnvironment.preprod
        #expect(environment.loginHost == "login.preprod.dev.infomaniak.ch")
    }

    @Test("Custom host environment login host")
    func customHostLoginHost() {
        let environment = ApiEnvironment.customHost("example.com")
        #expect(environment.loginHost == "login.example.com")
    }

    @Test("Custom host with orphan should use preprod login host")
    func customHostWithOrphanLoginHost() {
        let environment = ApiEnvironment.customHost("orphan.example.com")
        #expect(environment.loginHost == "login.preprod.dev.infomaniak.ch")
    }

    @Test("Custom host without orphan should use its own login host")
    func customHostWithoutOrphanLoginHost() {
        let environment = ApiEnvironment.customHost("custom.example.com")
        #expect(environment.loginHost == "login.custom.example.com")
    }
}
