//
//  DeputeDetailView.swift
//  test-jp
//
//  Created by Jérémie on 26/09/2024.
//

import SwiftUI

struct DeputeDetailView: View {
    let dataObject: ResultDepute?
    
    var body: some View {
        if let dataObject {

            ScrollView {
                
                AsyncImage(url: URL(string: "https://nosdeputes.fr/depute/photo/\(dataObject.prenom.lowercased())-\(dataObject.nom.lowercased())/250")) { image in
                    image.resizable()
                        .scaledToFit() // Ajuster selon tes besoins
                } placeholder: {
                    ZStack {
                        Color.black
                            .frame(width: 250, height: 250)
                            .border(Color.white)
                        
                        Text("Pas de données")
                            .foregroundColor(.white)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                    }
                }
                .frame(width: 250, height: 250)
                
                
                VStack {
                    Text("Député elu en 2024  dans la circonscription n°\(String(describing: dataObject.circo)) du département \(String(describing: dataObject.departementNom))\n")
                    
                    Text("Nom \(dataObject.nom)")
                    Text("Candidat \(dataObject.prenom)")
                    Text("Métier \(dataObject.job) voix")
                    if let username = dataObject.twitter.split(separator: "@").last {
                        Button {
                            if let url = URL(string: "twitter://user?screen_name=\(username)"),
                               UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url)
                            } else {
                                if let webUrl = URL(string: "https://twitter.com/\(username)") {
                                    UIApplication.shared.open(webUrl)
                                }
                            }
                        } label: {
                            Text("\(dataObject.twitter)")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    
                }
            }
        }
    }
}

#Preview {
    DeputeDetailView(dataObject: nil)
}
