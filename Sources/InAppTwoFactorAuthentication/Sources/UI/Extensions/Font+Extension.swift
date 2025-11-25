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

extension Font {
    enum Custom {
        /// Figma name: *Titre H2*
        static let title2 = Font.dynamicTypeSizeFont(size: 18, weight: .semibold, relativeTo: .title2)

        /// Figma name: *Body Medium*
        static let headline = Font.dynamicTypeSizeFont(size: 16, weight: .medium, relativeTo: .headline)

        /// Figma name: *Body Regular*
        static let body = Font.dynamicTypeSizeFont(size: 16, weight: .regular, relativeTo: .body)

        /// Figma name: *Body Small Regular*
        static let callout = Font.dynamicTypeSizeFont(size: 14, weight: .regular, relativeTo: .callout)
    }
}
