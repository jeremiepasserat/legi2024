//
//  DeputesView.swift
//  test-jp
//
//  Created by Jérémie on 25/09/2024.
//

import SwiftUI
import SwiftData

struct DeputesView: View {
   
    @Query(sort: \ResultDepute.id)
    private var donnesDeputes: [ResultDepute] = []
    
    var donnesRetraitees: [ResultDepute] {
        if deputeRecherche.isEmpty {
            return donnesDeputes
        } else {
            return donnesDeputes.filter({$0.nom.lowercased().contains(deputeRecherche.lowercased())})
        }
    }
    
    @State var deputeRecherche: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            
            List {
                TextField(" Rechercher un député", text: $deputeRecherche)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .frame(maxWidth: .infinity)
                    .padding([.vertical, .leading])
                    .background(deputeRecherche.isEmpty ? Color.red.opacity(0.3) : Color.green.opacity(0.3))
                    .cornerRadius(8)
                
                ForEach(donnesRetraitees, id: \.self){ result in
                    NavigationLink {
                        DeputeDetailView(dataObject: result)
                    } label: {
                        VStack (alignment: .leading) {
                            HStack{
                                Text ("\(result.nom.replacingOccurrences(of: "\"", with: "")) - \(result.prenom.replacingOccurrences(of: "\"", with: ""))")
                            }
                            
                            HStack{
                                if result.groupe.lowercased().starts(with: "socialistes") {
                                    Image("ps")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                }
                                if result.groupe.lowercased().starts(with: "droite") {
                                    Image("lr")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                }
                                if result.groupe.lowercased().starts(with: "ensemble") {
                                    Image("epr")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                }
                                if result.groupe.lowercased().starts(with: "rassemblement") {
                                    Image("rn")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                }
                                if result.groupe.lowercased().starts(with: "la france") {
                                    Image("lfi")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                }
                                if result.groupe.lowercased().starts(with: "horizons") {
                                    Image("hei")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                }
                                if result.groupe.lowercased().starts(with: "gauche démocrate") {
                                    Image("gdr")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                }
                                if result.groupe.lowercased().starts(with: "libertés") {
                                    Image("liot")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                }
                                if result.groupe.lowercased().starts(with: "udr") {
                                    Image("udr")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                }
                                if result.groupe.lowercased().starts(with: "écologiste") {
                                    Image("es")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                }
                                if result.groupe.lowercased().starts(with: "les démocrates") {
                                    Image("ld")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                }
                                Text ("\(result.groupe.replacingOccurrences(of: "\"", with: ""))")
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
        }
    }
}

#Preview {
//    DeputesView()
}
