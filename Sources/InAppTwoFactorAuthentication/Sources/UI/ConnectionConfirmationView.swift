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

import DesignSystem
import InfomaniakCore
import SwiftUI

extension DeviceType {
    var icon: Image {
        switch self {
        case .computer:
            Image(systemName: "laptopcomputer")
        case .phone:
            Image(systemName: "iphone.gen2")
        case .tablet:
            Image(systemName: "ipad.gen2")
        }
    }
}

extension RequestDevice {
    var description: String {
        guard let model else { return "\(platform)" }

        return "\(platform), \(model)"
    }
}

struct ConnectionConfirmationView: View {
    @Environment(\.dismiss) private var dismiss

    let user: InfomaniakUser
    let connectionConfirmationRequest: ConnectionConfirmationRequest

    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: IKPadding.medium) {
                    Image(systemName: "lock.shield")
                        .font(.system(size: 48))
                        .padding()
                        .background(Circle()
                            .fill(Color.white))

                    Text("!Are you trying to sign in?")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                }

                VStack(alignment: .leading) {
                    UserRowView(user: user)
                    Divider()

                    VStack {
                        VStack {
                            RowView(title: "!Date and time") {
                                Text(connectionConfirmationRequest.requestDate, style: .relative)
                            }

                            RowView(title: "!Device") {
                                HStack {
                                    Text(connectionConfirmationRequest.device.description)
                                    connectionConfirmationRequest.device.type.icon
                                }
                            }

                            RowView(title: "!Location", description: connectionConfirmationRequest.locationName)

                            VStack {
                                Text("!Confirming this connection will allow this device to access your Infomaniak account.")
                                    .foregroundColor(.secondary)

                                HStack {
                                    Button("!Deny") {}
                                        .buttonStyle(.ikBorderedProminent)
                                        .ikButtonFullWidth(true)
                                        .controlSize(.large)

                                    Button("!Approve") {}
                                        .buttonStyle(.ikBorderedProminent)
                                        .ikButtonFullWidth(true)
                                        .controlSize(.large)
                                }
                            }
                            .frame(maxHeight: .infinity, alignment: .bottom)
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(uiColor: .systemBackground))
                )
                .padding()
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("!Close", systemImage: "xmark", role: .cancel, action: dismiss.callAsFunction)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    ConnectionConfirmationView(user: PreviewUser.preview, connectionConfirmationRequest: .preview)
}
