//
//  CirconscriptionDetailView.swift
//  test-jp
//
//  Created by Jérémie on 26/09/2024.
//

import SwiftUI
import SwiftData

struct CirconscriptionDetailView: View {
    
    let dataObject: ResultCirconscription?
    @Query
    private var donnesDeputes: [ResultDepute] = []
    
    var body: some View {
        if let dataObject {
            ScrollView {
                
                VStack {
                    Text("Résultats de l'élection législative 2024 dans la circonscription \(dataObject.libelleCirconscriptionLegislative)\n")
                    
                    Text("Nombre d'inscrits :\(dataObject.inscrits)")
                    Text("Nombre de votants :\(dataObject.votants)\n")
                    
                    let sortedData = dataObject.candidats.sorted { $0.voix > $1.voix }
                        ForEach(sortedData){ resultat in
                            if resultat.elu {
                                Image(systemName: "crown.fill")
                            }
                            Text("parti \(resultat.nuance)")
                            Text("Candidat \(resultat.nom) \(resultat.prenom)")
                            if resultat.elu {
                                NavigationLink{
                                    DeputeDetailView(dataObject: donnesDeputes.filter{$0.nom.lowercased() == resultat.nom.lowercased()}.first)
                                } label: {
                                    Text("Voir le détail du député")
                                }
                            }
                            Text("Candidate \(resultat.elu) voix")
                        }
                    }
            }
        }
    }
}

#Preview {
    CirconscriptionDetailView(dataObject: nil)
}
