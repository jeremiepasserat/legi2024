//
//  AFView.swift
//  test-jp
//
//  Created by Jérémie on 27/08/2024.
//

import SwiftUI
import Alamofire
import InteractiveMap

struct ElectionResultsByDepartement {
    let codeDepartement: String
    let libelleDepartement: String
    let inscrits: Int
    let votants: Int
    let pourcentageVotants: Double
    let abstentions: Int
    let pourcentageAbstentions: Double
    let exprimes: Int
    let pourcentageExprimesInscrits: Double
    let pourcentageExprimesVotants: Double
    let blancs: Int
    let pourcentageBlancsInscrits: Double
    let pourcentageBlancsVotants: Double
    let nuls: Int
    let pourcentageNulsInscrits: Double
    let pourcentageNulsVotants: Double
    let resultatsParParti: [ResultatsParParti]
}

struct ResultatsParParti: Identifiable {
    let id: Int
    let nuance: String
    let voix: Int
    let pourcentageVoixInscrits: Double
    let pourcentageVoixExprimes: Double
}

struct AFView: View {
    
    @State var response: [ElectionResultsByDepartement] = []
    @State private var isLoading: Bool = true

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Chargement...")
            } else {
              
                List {
                    ForEach(response, id: \.codeDepartement){ result in
                        NavigationLink {
                            AFDetailView(dataObject: result)
                        } label: {
                            HStack{Text(result.codeDepartement) + Text (" ") + Text (result.libelleDepartement)}
                                .padding(.vertical)
                        }
//                        HStack {
//                            Text(result.codeDepartement) + Text (" ") + Text (result.libelleDepartement)
//                        }
                    }
                }
                
//                .chartStyle(CircularChartStyle())
            }
        }
        .onAppear{
            makeCall()
        }
        
    }
    
    func makeCall() {
        
        let url = "https://static.data.gouv.fr/resources/elections-legislatives-des-30-juin-et-7-juillet-2024-resultats-definitifs-du-1er-tour/20240710-171330/resultats-definitifs-par-departements.csv"
        
        AF.download(url).responseURL { response in
            switch response.result {
                case .success(let fileURL):
                    print("Fichier téléchargé à : \(fileURL)")
                    do {
                        let content = try String(contentsOf: fileURL, encoding: .utf8)
                        print("Contenu du fichier : \(content)")
                        let lines = content.components(separatedBy: .newlines)
                        var responseData: [ElectionResultsByDepartement] = []
                        var firstLine = false
                        for line in lines {
                            if firstLine, !line.isEmpty {
                                responseData.append(parseElectionResults(from: line)!)
                            } else {
                                firstLine = true
                            }
                        }
                        self.response = responseData
                        self.isLoading = false
                    } catch {
                        print("Erreur lors de la lecture du fichier : \(error)")
                    }
                    // Vous pouvez maintenant utiliser fileURL pour accéder au fichier
                case .failure(let error):
                    print("Erreur lors du téléchargement : \(error)")
            }
        }
    }
    
    func parseElectionResults(from data: String) -> ElectionResultsByDepartement? {
        let components = data.components(separatedBy: ";")
        
//        guard components.count >= 15 else {
//            print("Données insuffisantes")
//            return nil
//        }
        
        // Extraire les valeurs
        let codeDepartement = components[0]
        let libelleDepartement = components[1]
        let inscrits = Int(components[2]) ?? 0
        let votants = Int(components[3]) ?? 0
        let pourcentageVotants = Double(components[4].replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "%", with: "")) ?? 0.0
        let abstentions = Int(components[5]) ?? 0
        let pourcentageAbstentions = Double(components[6].replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "%", with: "")) ?? 0.0
        let exprimes = Int(components[7]) ?? 0
        let pourcentageExprimesInscrits = Double(components[8].replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "%", with: "")) ?? 0.0
        let pourcentageExprimesVotants = Double(components[9].replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "%", with: "")) ?? 0.0
        let blancs = Int(components[10]) ?? 0
        let pourcentageBlancsInscrits = Double(components[11].replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "%", with: "")) ?? 0.0
        let pourcentageBlancsVotants = Double(components[12].replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "%", with: "")) ?? 0.0
        let nuls = Int(components[13]) ?? 0
        let pourcentageNulsInscrits = Double(components[14].replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "%", with: "")) ?? 0.0
        let pourcentageNulsVotants = Double(components[15].replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "%", with: "")) ?? 0.0
        
        // Extraire les candidats
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
        
        // Créer et retourner l'instance de ElectionResults
        return ElectionResultsByDepartement(
            codeDepartement: codeDepartement,
            libelleDepartement: libelleDepartement,
            inscrits: inscrits,
            votants: votants,
            pourcentageVotants: pourcentageVotants,
            abstentions: abstentions,
            pourcentageAbstentions: pourcentageAbstentions,
            exprimes: exprimes,
            pourcentageExprimesInscrits: pourcentageExprimesInscrits,
            pourcentageExprimesVotants: pourcentageExprimesVotants,
            blancs: blancs,
            pourcentageBlancsInscrits: pourcentageBlancsInscrits,
            pourcentageBlancsVotants: pourcentageBlancsVotants,
            nuls: nuls,
            pourcentageNulsInscrits: pourcentageNulsInscrits,
            pourcentageNulsVotants: pourcentageNulsVotants,
            resultatsParParti: candidats
        )
    }
}


#Preview {
    AFView()
}
