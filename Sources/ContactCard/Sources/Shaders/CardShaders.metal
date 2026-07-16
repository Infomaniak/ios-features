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

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[ stitchable ]] half4 cardSpecular(
    float2 position,
    SwiftUI::Layer layer,
    float2 size,
    float2 lightDir,
    float intensity,
    float specPower
) {
    half4 src = layer.sample(position);
    float2 uv = position / size;

    // Diagonal light sweep driven by motion
    float diagonal = uv.x + uv.y;
    float lightPos = 0.5 + lightDir.x * 0.5;
    float spec = exp(-pow(diagonal - lightPos, 2) * specPower);

    // Radial mask to keep highlight inside the card shape
    float radial = 1.0 - smoothstep(0.3, 0.6, distance(uv, float2(0.5)));
    spec *= radial;

    // Additive specular highlight
    half4 highlight = half4(1.0, 1.0, 1.0, 1.0) * half(spec * intensity);

    return src + highlight * half(src.a);
}
