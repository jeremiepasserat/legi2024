//
//  TestView.swift
//  test-jp
//
//  Created by Jérémie on 26/08/2024.
//

import SwiftUI
import SwiftData

struct TestView: View {
    
    var body: some View {
        
        
        NavigationView {
            
            VStack {
                
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
        .onAppear{
            // self.items = viewModel.loadData()
        }
    }
}
