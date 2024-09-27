//
//  Item.swift
//  test-jp
//
//  Created by Jérémie on 26/08/2024.
//

import Foundation
import SwiftData

@Model
final class ResultDepartment {
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
    
//    init(codeDepartement: String, libelleDepartement: String, inscrits: Int, votants: Int, pourcentageVotants: Double, abstentions: Int, pourcentageAbstentions: Double, exprimes: Int, pourcentageExprimesInscrits: Double, pourcentageExprimesVotants: Double, blancs: Int, pourcentageBlancsInscrits: Double, pourcentageBlancsVotants: Double, nuls: Int, pourcentageNulsInscrits: Double, pourcentageNulsVotants: Double, resultatsParParti: [ResultatsParParti]) {
//        self.codeDepartement = codeDepartement
//        self.libelleDepartement = libelleDepartement
//        self.inscrits = inscrits
//        self.votants = votants
//        self.pourcentageVotants = pourcentageVotants
//        self.abstentions = abstentions
//        self.pourcentageAbstentions = pourcentageAbstentions
//        self.exprimes = exprimes
//        self.pourcentageExprimesInscrits = pourcentageExprimesInscrits
//        self.pourcentageExprimesVotants = pourcentageExprimesVotants
//        self.blancs = blancs
//        self.pourcentageBlancsInscrits = pourcentageBlancsInscrits
//        self.pourcentageBlancsVotants = pourcentageBlancsVotants
//        self.nuls = nuls
//        self.pourcentageNulsInscrits = pourcentageNulsInscrits
//        self.pourcentageNulsVotants = pourcentageNulsVotants
//        self.resultatsParParti = resultatsParParti
//    }
    
    init(from data: String) {
        let components = data.components(separatedBy: ";").map { $0.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\"", with: "") }
        
        codeDepartement = (Int(components[0]) ?? 99) < 10 ? "\(components[0])" : components[0]
        libelleDepartement = components[1]
        inscrits = Int(components[2]) ?? 0
        votants = Int(components[3]) ?? 0
        pourcentageVotants = Double(components[4].replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "%", with: "")) ?? 0.0
        abstentions = Int(components[5]) ?? 0
        pourcentageAbstentions = Double(components[6].replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "%", with: "")) ?? 0.0
        exprimes = Int(components[7]) ?? 0
        pourcentageExprimesInscrits = Double(components[8].replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "%", with: "")) ?? 0.0
        pourcentageExprimesVotants = Double(components[9].replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "%", with: "")) ?? 0.0
        blancs = Int(components[10]) ?? 0
        pourcentageBlancsInscrits = Double(components[11].replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "%", with: "")) ?? 0.0
        pourcentageBlancsVotants = Double(components[12].replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "%", with: "")) ?? 0.0
        nuls = Int(components[13]) ?? 0
        pourcentageNulsInscrits = Double(components[14].replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "%", with: "")) ?? 0.0
        pourcentageNulsVotants = Double(components[15].replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "%", with: "")) ?? 0.0
        
        var candidats: [ResultatsParParti] = []
        var numero = 1
        
        for i in stride(from: 16, to: components.count, by: 4) {
            guard i + 3 < components.count else { break }
            let nuance = components[i]
            let voix = Int(components[i + 1]) ?? 0
            let pourcentageVoixInscrits = Double(components[i + 2].replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "%", with: "")) ?? 0.0
            let pourcentageVoixExprimes = Double(components[i + 3].replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "%", with: "")) ?? 0.0
            
            if !nuance.isEmpty { // Vérifier que la nuance n'est pas vide
                let candidat = ResultatsParParti(id: numero, nuance: nuance, voix: voix, pourcentageVoixInscrits: pourcentageVoixInscrits, pourcentageVoixExprimes: pourcentageVoixExprimes)
                candidats.append(candidat)
            }
            numero += 1
        }
        
        resultatsParParti = candidats
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
