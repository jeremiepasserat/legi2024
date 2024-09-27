//
//  CirconscriptionView.swift
//  test-jp
//
//  Created by Jérémie on 26/09/2024.
//

import SwiftUI
import SwiftData

struct CirconscriptionView: View {
    
    @Query(sort: \ResultCirconscription.codeCirconscriptionLegislative)
    private var electionResultsByCirconscription: [ResultCirconscription] = []
    
    var circonscriptionResults: [ResultCirconscription] = []
    
    var body: some View {
        VStack {
            
            List {
                let circoncscriptionData =  circonscriptionResults.isEmpty ? electionResultsByCirconscription : circonscriptionResults
                ForEach(circoncscriptionData.sorted { $0.codeCirconscriptionLegislative < $1.codeCirconscriptionLegislative }, id: \.codeCirconscriptionLegislative){ result in
                    NavigationLink {
                        CirconscriptionDetailView(dataObject: result)
                    } label: {
                        HStack{Text(result.codeCirconscriptionLegislative)
                            
                            HStack{Text(result.codeDepartement) + Text (" ") + Text (result.libelleDepartement)}
                        }
                        .padding(.vertical)
                    }
                }
            }
        }
    }
}

#Preview {
    CirconscriptionView()
}
