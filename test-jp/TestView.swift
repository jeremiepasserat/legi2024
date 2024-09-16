//
//  TestView.swift
//  test-jp
//
//  Created by Jérémie on 26/08/2024.
//

import SwiftUI
import SwiftData

struct TestView: View {
    
    @StateObject var viewModel = AFViewModel()
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        
        NavigationView {
            
            VStack {
                
                if self.viewModel.isLoading {
                    ProgressView("Initialisation de l'application...")
                } else {
                    
                    Text("Bienvenue sur mon app")
                        .font(.system(size: 30))
                        .fontWeight(.medium)
                        .fontDesign(.rounded)
                        .padding(.vertical)
                    
                    List {
                        NavigationLink {
                            ContentView()
                        } label: {
                            Text("List & Sheet View (SwiftData)")
                                .padding(.vertical)
                        }
                        
                        NavigationLink {
                            AFView()
                        } label: {
                            Text("Résultats élections")
                                .padding(.vertical)
                        }
                        
                        NavigationLink {
                            AFMapView()
                        } label: {
                            Text("Résultats élections (carte)")
                                .padding(.vertical)
                        }
                        
                        NavigationLink {
                            Text("Test 4")
                        } label: {
                            Text("Test 4")
                                .padding(.vertical)
                            
                        }
                        
                        NavigationLink {
                            Text("Test 5")
                        } label: {
                            Text("Test 5")
                                .padding(.vertical)
                        }
                    }

                }
            }
            
        }
        .onAppear{
//            Task {
                self.viewModel.makeCall()
                self.modelContext.insert(ElectionResultsByDepartement(codeDepartement: "", libelleDepartement: "", inscrits: 1, votants: 1, pourcentageVotants: 1.0, abstentions: 1, pourcentageAbstentions: 1.0, exprimes: 1, pourcentageExprimesInscrits: 1.0, pourcentageExprimesVotants: 1.0, blancs: 1, pourcentageBlancsInscrits: 1.0, pourcentageBlancsVotants: 1.0, nuls: 1, pourcentageNulsInscrits: 1.0, pourcentageNulsVotants: 1.0, resultatsParParti: [ResultatsParParti(id: 1, nuance: "", voix: 1, pourcentageVoixInscrits: 1.0, pourcentageVoixExprimes: 1.0)]))
                for respons in viewModel.response {
                    self.modelContext.insert(respons)
                }
                print("Done")
//            }
        }
    }
}
