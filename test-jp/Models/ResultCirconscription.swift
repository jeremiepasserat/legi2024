//
//  ResultsCirconscription.swift
//  test-jp
//
//  Created by Jérémie on 26/09/2024.
//

import Foundation
import SwiftData

@Model
class ResultCirconscription {
    var codeDepartement: String
    var libelleDepartement: String
    var codeCirconscriptionLegislative: String
    var libelleCirconscriptionLegislative: String
    var inscrits: Int
    var votants: Int
    var pourcentageVotants: Double
    var abstentions: Int
    var pourcentageAbstentions: Double
    var exprimes: Int
    var pourcentageExprimesInscrits: Double
    var pourcentageExprimesVotants: Double
    var blancs: Int
    var pourcentageBlancsInscrits: Double
    var pourcentageBlancsVotants: Double
    var nuls: Int
    var pourcentageNulsInscrits: Double
    var pourcentageNulsVotants: Double
    
    // Propriétés pour les candidats
    var candidats: [ResultParCandidat] = []

    init(from csvLine: String) {
        let components = csvLine.components(separatedBy: ";").map { $0.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\"", with: "") }

        codeDepartement = components[0]
        libelleDepartement = components[1]
        codeCirconscriptionLegislative = components[2]
        libelleCirconscriptionLegislative = components[3]
        inscrits = Int(components[4]) ?? 0
        votants = Int(components[5]) ?? 0
        pourcentageVotants = Double(components[6]) ?? 0.0
        abstentions = Int(components[7]) ?? 0
        pourcentageAbstentions = Double(components[8]) ?? 0.0
        exprimes = Int(components[9]) ?? 0
        pourcentageExprimesInscrits = Double(components[10]) ?? 0.0
        pourcentageExprimesVotants = Double(components[11]) ?? 0.0
        blancs = Int(components[12]) ?? 0
        pourcentageBlancsInscrits = Double(components[13]) ?? 0.0
        pourcentageBlancsVotants = Double(components[14]) ?? 0.0
        nuls = Int(components[15]) ?? 0
        pourcentageNulsInscrits = Double(components[16]) ?? 0.0
        pourcentageNulsVotants = Double(components[17]) ?? 0.0
        
//        // Initialisation des candidats
//        for i in 0..<4 { // Si tu as 4 panneaux
//            let index = 18 + i * 13 // Ajuste en fonction de ton CSV
//            let candidat = ResultParCandidat(
//                numPanneau: components[index],
//                nuance: components[index + 1],
//                nom: components[index + 2],
//                prenom: components[index + 3],
//                sexe: components[index + 4],
//                voix: Int(components[index + 5]) ?? 0,
//                pourcentageVoixInscrits: Double(components[index + 6]) ?? 0.0,
//                pourcentageVoixExprimes: Double(components[index + 7]) ?? 0.0,
//                elu: components[index + 8].lowercased() == "oui"
//            )
//            candidats.append(candidat)
//        }
//        
        for i in stride(from: 18, to: components.count, by: 9) {
            guard i + 8 < components.count else { break }
            let candidat = ResultParCandidat(
                numPanneau: components[i],
                nuance: components[i + 1],
                nom: components[i + 2],
                prenom: components[i + 3],
                sexe: components[i + 4],
                voix: Int(components[i + 5]) ?? 0,
                pourcentageVoixInscrits: Double(components[i + 6]) ?? 0.0,
                pourcentageVoixExprimes: Double(components[i + 7]) ?? 0.0,
                elu: components[i + 8].lowercased() == "élu"
            )
            candidats.append(candidat)
        }
    }
}

@Model
class ResultParCandidat {
    var numPanneau: String
    var nuance: String
    var nom: String
    var prenom: String
    var sexe: String
    var voix: Int
    var pourcentageVoixInscrits: Double
    var pourcentageVoixExprimes: Double
    var elu: Bool

    init(numPanneau: String, nuance: String, nom: String, prenom: String, sexe: String, voix: Int, pourcentageVoixInscrits: Double, pourcentageVoixExprimes: Double, elu: Bool) {
        self.numPanneau = numPanneau
        self.nuance = nuance
        self.nom = nom
        self.prenom = prenom
        self.sexe = sexe
        self.voix = voix
        self.pourcentageVoixInscrits = pourcentageVoixInscrits
        self.pourcentageVoixExprimes = pourcentageVoixExprimes
        self.elu = elu
    }
}

