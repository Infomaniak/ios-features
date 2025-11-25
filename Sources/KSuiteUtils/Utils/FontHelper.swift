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

public enum FontHelper {
    private static func dynamicTypeSizeFont(size: CGFloat, weight: Font.Weight, relativeTo textStyle: Font.TextStyle) -> Font {
        let fontFamily = UIFont.preferredFont(forTextStyle: .body).familyName
        return Font.custom(fontFamily, size: size, relativeTo: textStyle).weight(weight)
    }

    public static let title: Font = dynamicTypeSizeFont(size: 18, weight: .semibold, relativeTo: .title2)

    // MARK: - Regular

    public static let body: Font = dynamicTypeSizeFont(size: 16, weight: .regular, relativeTo: .body)
    public static let bodySmall: Font = dynamicTypeSizeFont(size: 14, weight: .regular, relativeTo: .callout)

    // MARK: - Medium

    public static let bodyMedium: Font = dynamicTypeSizeFont(size: 16, weight: .medium, relativeTo: .headline)

    public static let bodySmallMedium: Font = dynamicTypeSizeFont(size: 14, weight: .medium, relativeTo: .callout)
    public static let labelMedium: Font = dynamicTypeSizeFont(size: 12, weight: .medium, relativeTo: .caption)
}
