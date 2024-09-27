//
//  HomeView.swift
//  test-jp
//
//  Created by Jérémie on 26/08/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
        
    var body: some View {
        
        
        VStack {
            Text("Résultats Elections Legislatives 2024")
                .font(.system(size: 30))
                .fontWeight(.medium)
                .fontDesign(.rounded)
                .padding(.vertical)
            
            List {
                
                NavigationLink {
                    DepartmentView()
                } label: {
                    Text("Résultats élections par département")
                        .padding(.vertical)
                }
                
                NavigationLink {
                    DepartmentMapView()
                } label: {
                    Text("Résultats élections par département(carte)")
                        .padding(.vertical)
                }
                
                NavigationLink {
                    CirconscriptionView()
                } label: {
                    Text("Résultats élections par circonscription")
                        .padding(.vertical)
                    
                }
                
                NavigationLink {
                    DeputesView()
                } label: {
                    Text("Les députés élus")
                        .padding(.vertical)
                }
                
            }
        }
    }
}
