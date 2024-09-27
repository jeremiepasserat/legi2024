//
//  ResultsDepute.swift
//  test-jp
//
//  Created by Jérémie on 26/09/2024.
//

import Foundation
import SwiftData

@Model
class ResultDepute {
    var id: String
    var legislature: String
    var civ: String
    var nom: String
    var prenom: String
    var villeNaissance: String
    var naissance: String
    var age: Int
    var groupe: String
    var groupeAbrev: String?
    var departementNom: String?
    var departementCode: String?
    var circo: String?
    var datePriseFonction: String
    var job: String
    var mail: String
    var twitter: String
    var facebook: String
    var website: String
    var nombreMandats: Int?
    var experienceDepute: String?
    var scoreParticipation: Double?
    var scoreParticipationSpecialite: Double?
    var scoreLoyaute: Double?
    var scoreMajorite: Double?
    var dateMaj: String
    
    init(from csvLine: String) {
        let components = csvLine.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\"", with: "") }
        
        if !csvLine.starts(with: "PA") {
            print ("CSV line \(csvLine)")
        }
        
        id = components.indices.contains(0) ? components[0] : ""
        legislature = components.indices.contains(1) ? components[1] : ""
        civ = components.indices.contains(2) ? components[2] : ""
        nom = components.indices.contains(3) ? components[3] : ""
        prenom = components.indices.contains(4) ? components[4] : ""
        villeNaissance = components.indices.contains(5) ? components[5] : ""
        naissance = components.indices.contains(6) ? components[6] : ""
        age = components.indices.contains(7) ? (Int(components[7]) ?? 0) : 0
        groupe = components.indices.contains(8) ? components[8] : ""
        groupeAbrev = components.indices.contains(9) ? components[9] : nil
        departementNom = components.indices.contains(10) ? components[10] : nil
        departementCode = components.indices.contains(11) ? components[11] : nil
        circo = components.indices.contains(12) ? components[12] : nil
        datePriseFonction = components.indices.contains(13) ? components[13] : ""
        job = components.indices.contains(14) ? components[14] : ""
        mail = components.indices.contains(15) ? components[15] : ""
        twitter = components.indices.contains(16) ? components[16] : ""
        facebook = components.indices.contains(17) ? components[17] : ""
        website = components.indices.contains(18) ? components[18] : ""
        nombreMandats = components.indices.contains(19) ? (Int(components[19]) ?? nil) : nil
        experienceDepute = components.indices.contains(20) ? components[20] : nil
        scoreParticipation = components.indices.contains(21) ? (Double(components[21]) ?? nil) : nil
        scoreParticipationSpecialite = components.indices.contains(22) ? (Double(components[22]) ?? nil) : nil
        scoreLoyaute = components.indices.contains(23) ? (Double(components[23]) ?? nil) : nil
        scoreMajorite = components.indices.contains(24) ? (Double(components[24]) ?? nil) : nil
        dateMaj = components.indices.contains(25) ? components[25] : ""
    }
}
