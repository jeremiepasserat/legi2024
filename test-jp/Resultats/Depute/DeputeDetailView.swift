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
            ZStack {
                Color.blue
                    .border(.black)
                    .opacity(0.10)
                    .cornerRadius(12)
                    .padding(.horizontal)

                VStack {
                    
                    Text("\(dataObject.nom)")
                    Text("\(dataObject.prenom)")
                    
                    AsyncImage(url: URL(string: "https://nosdeputes.fr/depute/photo/\(dataObject.prenom.lowercased())-\(dataObject.nom.lowercased())/250")) { image in
                        image.resizable()
                            .scaledToFit()
                            .cornerRadius(9)
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
                    .padding(.top, -60)
                    .padding(.bottom)

                    VStack {
                        
                        Text("Circonscription n° \(dataObject.circo!)")
                        Text("Département: \(dataObject.departementNom!)")
                            .padding(.bottom)
                        
                        Text("\(dataObject.groupe)")
                            .padding(.bottom)
                        
                        Text("Métier: \(dataObject.job)")
                        
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
                    .padding()
                }
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    DeputeDetailView(dataObject: nil)
}
