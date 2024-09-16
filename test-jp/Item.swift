//
//  Item.swift
//  test-jp
//
//  Created by Jérémie on 26/08/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

@Model
final class ElaboratedItem {
    var label: String
    
    init(label: String) {
        self.label = label
    }
}

@Model
final class ElectionResultsByDepartement {
    var codeDepartement: String
    var libelleDepartement: String
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
    var resultatsParParti: [ResultatsParParti]
    
    init(codeDepartement: String, libelleDepartement: String, inscrits: Int, votants: Int, pourcentageVotants: Double, abstentions: Int, pourcentageAbstentions: Double, exprimes: Int, pourcentageExprimesInscrits: Double, pourcentageExprimesVotants: Double, blancs: Int, pourcentageBlancsInscrits: Double, pourcentageBlancsVotants: Double, nuls: Int, pourcentageNulsInscrits: Double, pourcentageNulsVotants: Double, resultatsParParti: [ResultatsParParti]) {
        self.codeDepartement = codeDepartement
        self.libelleDepartement = libelleDepartement
        self.inscrits = inscrits
        self.votants = votants
        self.pourcentageVotants = pourcentageVotants
        self.abstentions = abstentions
        self.pourcentageAbstentions = pourcentageAbstentions
        self.exprimes = exprimes
        self.pourcentageExprimesInscrits = pourcentageExprimesInscrits
        self.pourcentageExprimesVotants = pourcentageExprimesVotants
        self.blancs = blancs
        self.pourcentageBlancsInscrits = pourcentageBlancsInscrits
        self.pourcentageBlancsVotants = pourcentageBlancsVotants
        self.nuls = nuls
        self.pourcentageNulsInscrits = pourcentageNulsInscrits
        self.pourcentageNulsVotants = pourcentageNulsVotants
        self.resultatsParParti = resultatsParParti
    }
}

@Model
final class ResultatsParParti: Identifiable {
    var id: Int
    var nuance: String
    var voix: Int
    var pourcentageVoixInscrits: Double
    var pourcentageVoixExprimes: Double
    
    init(id: Int, nuance: String, voix: Int, pourcentageVoixInscrits: Double, pourcentageVoixExprimes: Double) {
          self.id = id
          self.nuance = nuance
          self.voix = voix
          self.pourcentageVoixInscrits = pourcentageVoixInscrits
          self.pourcentageVoixExprimes = pourcentageVoixExprimes
      }
}
