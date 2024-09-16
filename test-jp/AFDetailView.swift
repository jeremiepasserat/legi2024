//
//  AFDetailView.swift
//  test-jp
//
//  Created by Jérémie on 09/09/2024.
//

import SwiftUI
import Charts
struct AFDetailView: View {
    
    let dataObject: ElectionResultsByDepartement?
    
    var body: some View {
        if let dataObject {
            ScrollView {
                
                VStack {
                    Text("Résultats de l'élection législative 2024 dans le département \(dataObject.libelleDepartement)\n")
                    
                    Text("Nombre d'inscrits :\(dataObject.inscrits)")
                    Text("Nombre de votants :\(dataObject.votants)\n")
                    
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
    AFDetailView(dataObject: nil)
}
