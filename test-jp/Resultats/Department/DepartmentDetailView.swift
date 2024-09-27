//
//  AFDetailView.swift
//  test-jp
//
//  Created by Jérémie on 09/09/2024.
//

import SwiftUI
import Charts
import SwiftData

struct DepartmentDetailView: View {
    
    let dataObject: ResultDepartment?
    @Query(sort: \ResultCirconscription.codeCirconscriptionLegislative)
    private var electionResultsByCirconscription: [ResultCirconscription] = []
    
    var body: some View {
        if let dataObject {
            ScrollView {
                
                VStack {
                    Text("Résultats de l'élection législative 2024 dans le département \(dataObject.libelleDepartement)\n")
                    
                    Text("Nombre d'inscrits :\(dataObject.inscrits)")
                    Text("Nombre de votants :\(dataObject.votants)\n")
                    
                    NavigationLink{
                        CirconscriptionView(circonscriptionResults: electionResultsByCirconscription.filter{$0.libelleDepartement == dataObject.libelleDepartement})
                    } label: {
                        Text("Voir le détail des circonscriptions")
                    }
                    
                    let sortedData = dataObject.resultatsParParti.sorted { $0.voix > $1.voix }
                        ForEach(sortedData){ resultat in
                            Text("parti \(resultat.nuance)")
                            Text("nombre de voix \(resultat.voix)")
                        }
                        
                        Chart {
                            ForEach(sortedData) { resultat in
                                SectorMark(
                                    angle: .value("Voix", resultat.voix)
                                )
                                .foregroundStyle(by: .value("Parti", resultat.nuance))
                            }
                        }
                        .frame(height: 300)
                        .padding()
                    }
            }
        }
    }
}

#Preview {
    DepartmentDetailView(dataObject: nil)
}
