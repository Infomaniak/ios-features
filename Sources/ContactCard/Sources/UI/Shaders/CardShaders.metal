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
using namespace metal;
#include <SwiftUI/SwiftUI.h>

[[ stitchable ]] half4 specularHighlight(
    float2 position,
    SwiftUI::Layer layer,
    float4 bounds,
    float2 tilt
) {
    half4 color = layer.sample(position);
    float2 size = float2(bounds.z, bounds.w);
    float2 center = size / 2.0;
    float2 highlightCenter = center + float2(tilt.x * size.x * 0.4, tilt.y * size.y * 0.4);
    float dist = distance(position, highlightCenter);
    float maxDist = min(size.x, size.y) / 2.0;
    float specular = exp(-(dist * dist) / (maxDist * maxDist * 0.15));
    half4 white = half4(1.0, 1.0, 1.0, specular * 0.35);
    return mix(color, white, white.a);
}
