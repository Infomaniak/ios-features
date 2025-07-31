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

import KSuiteUtils

public enum KSuiteConfiguration {
    case standard
    case business
    case enterprise

    var title: String {
        switch self {
        case .standard:
            "Passez à la vitesse supérieure avec l'offre standard"
        case .business:
            "Gagnez en impact et en maîtrise avec l'offre business"
        case .enterprise:
            "Sécurisez, centralisez, maîtrisez avec l'offre Enterprise"
        }
    }

    var description: String {
        switch self {
        case .standard:
            "Donnez à votre équipe les outils essentiels pour collaborer efficacement au quotidien."
        case .business:
            "Optimisez vos échanges et structurez la collaboration à l'échelle de votre organisation."
        case .enterprise:
            "Un environnement de collaboration sécurisé pour vos équipes, même les plus exigeantes."
        }
    }

    var labels: [KSuiteUtils.KSuiteLabel] {
        switch self {
        case .standard:
            [
                KSuiteLabel(
                    icon: KSuiteResources.drive.swiftUIImage,
                    text: "50 Go par utilisateur de stockage cloud kDrive et kChat"
                ),
                KSuiteLabel(
                    icon: KSuiteResources.kchat.swiftUIImage,
                    text: "kChat : historique des messages illimités, plus de canaux, etc."
                ),
                KSuiteLabel(
                    icon: KSuiteResources.envelope.swiftUIImage,
                    text: "Mail : stockage messagerie illimité, envoi programmé, etc."
                ),
                KSuiteLabel(
                    icon: KSuiteResources.euria.swiftUIImage,
                    text: "Euria : transcriptiondes vidéos, création d'image, etc."
                ),
                KSuiteLabel(
                    icon: KSuiteResources.plusCircle.swiftUIImage,
                    text: "Et bien plus encore !"
                )
            ]
        case .business:
            [
                KSuiteLabel(
                    icon: KSuiteResources.drive.swiftUIImage,
                    text: "3 To par utilisateur de stockage cloud kDrive et kChat"
                ),
                KSuiteLabel(
                    icon: KSuiteResources.kchat.swiftUIImage,
                    text: "kChat : canaux partagés, intégration d'autres applications illimité"
                ),
                KSuiteLabel(
                    icon: KSuiteResources.folder.swiftUIImage,
                    text: "kDrive: recherche dans le contenu, historique de versions étendu"
                ),
                KSuiteLabel(
                    icon: KSuiteResources.shieldLock.swiftUIImage,
                    text: "Sécurité : Login SSO, sauvegarde PC, etc."
                ),
                KSuiteLabel(
                    icon: KSuiteResources.plusCircle.swiftUIImage,
                    text: "Et bien plus encore !"
                )
            ]
        case .enterprise:
            [
                KSuiteLabel(
                    icon: KSuiteResources.drive.swiftUIImage,
                    text: "6 To par utilisateur de stockage cloud kDrive et kChat"
                ),
                KSuiteLabel(
                    icon: KSuiteResources.kchat.swiftUIImage,
                    text: "kChat : 200 utilisateurs externes, jusqu'à 1000 canaux publics/privés"
                ),
                KSuiteLabel(
                    icon: KSuiteResources.stair.swiftUIImage,
                    text: "Fonctionnalités avancées : Support Premium, Custom Brand, etc."
                ),
                KSuiteLabel(
                    icon: KSuiteResources.microsoft.swiftUIImage,
                    text: "Intégration Microsoft Office Online"
                ),
                KSuiteLabel(
                    icon: KSuiteResources.plusCircle.swiftUIImage,
                    text: "Et bien plus encore !"
                )
            ]
        }
    }
}
