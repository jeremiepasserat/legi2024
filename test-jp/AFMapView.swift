//
//  AFMapView.swift
//  test-jp
//
//  Created by Jérémie on 12/09/2024.
//

import SwiftUI
import InteractiveMap

struct AFMapView: View {
    
    @State private var clickedPath = PathData()
    @State private var currentZoom = 0.0
    @State private var totalZoom = 1.0
    @State private var lastOffset: CGSize = .zero // Pour conserver la dernière position
    @State private var offset: CGSize = .zero // Pour le déplacement
    @State private var refreshToggle = false
    private var depName: String {
        clickedPath.name.isEmpty ? "" : "\(clickedPath.name.suffix(2))"
    }
    
    
    var body: some View {
        
        VStack {
            
            ZStack {
                if let departementName = departements[depName] {
                    
                    VStack {
                        Text("Résultats législatives dans le département \(departementName)")
                            .font(.title)
                            .padding(.horizontal)
                            .padding(.vertical)
                        
                        Button{
                            print("Puuuuuuuuuuuu")
                        } label: {
                            Text("Détail des résultats")
                        }
                    }
                    
                    
                } else {
                    Text("Sélectionnez un département pour voir les résultats")
                        .font(.title)
                    //                        .frame(height: 150, alignment: .top)
                        .padding(.horizontal)
                        .padding(.top)
                }
            }
            .frame(height: 150, alignment: .top)
            
            
            InteractiveMap(svgName: "depart") { pathData in // or just use $0
                InteractiveShape(pathData)
                    .stroke(.white)
                    .fill(clickedPath == pathData ? .cyan : .red)
                    .zIndex(clickedPath == pathData ? 2 : 1) // this is REQUIRED because InteractiveShapes overlap, resulting in an ugly appearance
                    .animation(.easeInOut(duration: 0.3), value: clickedPath)
                    .onTapGesture {
                        clickedPath = pathData
                    }
                
            }
            //            .border(.orange)
            .scaleEffect(currentZoom + totalZoom)
            .offset(x: offset.width, y: offset.height)
            //            .frame(maxWidth: .infinity, maxHeight: 250, alignment: .center)
            .gesture(
                MagnifyGesture()
                    .onChanged { value in
                        print("Prout")
                        //                        currentZoom = value.magnification - 1
                        let zoomFactor = value.magnification - 1
                        currentZoom = min(max(zoomFactor, 0.5 - totalZoom), 2.0 - totalZoom)
                    }
                    .onEnded { value in
                        totalZoom += currentZoom
                        if totalZoom < 0.5 {
                            totalZoom = 0.5
                        }  else if totalZoom > 2.0 {
                            totalZoom = 2.0
                        }
                        currentZoom = 0
                    }
            )
            //            .simultaneousGesture(
            //                DragGesture()
            //                    .onChanged { value in
            //                        print("Pétoule")
            //                        let speedFactor: CGFloat = 0.25
            //                        if totalZoom > 1.0 {
            //                            offset = CGSize(
            //                                width: (lastOffset.width + value.translation.width) * speedFactor,
            //                                height: lastOffset.height + value.translation.height  * speedFactor
            //                            )
            //                        }
            //                    }
            //                    .onEnded { value in
            //                        lastOffset = offset
            //                    }
            //            )
            .simultaneousGesture(
                DragGesture()
                    .onChanged { value in
                        print("Pétoule")
                        
                        // Facteur de vitesse pour ajuster la vitesse de déplacement
                        let speedFactor: CGFloat = 0.25
                        
                        // Taille de l'image visible dans la vue
                        let imageWidth = 200.0  // Par exemple
                        let imageHeight = 200.0 // Par exemple
                        
                        // Limite du mouvement en fonction de la taille de l'image et du zoom
                        let maxOffsetX = (imageWidth * (totalZoom - 1)) / 2
                        let maxOffsetY = (imageHeight * (totalZoom - 1)) / 2
                        
                        if totalZoom > 1.0 {
                            var newOffset = CGSize(
                                width: (lastOffset.width + value.translation.width) * speedFactor,
                                height: (lastOffset.height + value.translation.height) * speedFactor
                            )
                            
                            // Limiter le déplacement à la zone définie
                            newOffset.width = min(max(newOffset.width, -maxOffsetX), maxOffsetX)
                            newOffset.height = min(max(newOffset.height, -maxOffsetY), maxOffsetY)
                            
                            offset = newOffset
                        }
                    }
                    .onEnded { value in
                        lastOffset = offset
                    }
            )
            .padding()
            
        }
        Button{
            offset = .zero
            totalZoom = 1.0
            refreshToggle.toggle()
        } label: {
            Text("Reset to default")
        }
        
    }
    
    let departements: [String: String] = [
        "01": "Ain",
        "02": "Aisne",
        "03": "Allier",
        "04": "Alpes-de-Haute-Provence",
        "05": "Hautes-Alpes",
        "06": "Alpes-Maritimes",
        "07": "Ardèche",
        "08": "Ardennes",
        "09": "Ariège",
        "10": "Aube",
        "11": "Aude",
        "12": "Aveyron",
        "13": "Bouches-du-Rhône",
        "14": "Calvados",
        "15": "Cantal",
        "16": "Charente",
        "17": "Charente-Maritime",
        "18": "Cher",
        "19": "Corrèze",
        "2A": "Corse-du-Sud",
        "2B": "Haute-Corse",
        "21": "Côte-d'Or",
        "22": "Côtes-d'Armor",
        "23": "Creuse",
        "24": "Dordogne",
        "25": "Doubs",
        "26": "Drôme",
        "27": "Eure",
        "28": "Eure-et-Loir",
        "29": "Finistère",
        "30": "Gard",
        "31": "Haute-Garonne",
        "32": "Gers",
        "33": "Gironde",
        "34": "Hérault",
        "35": "Ille-et-Vilaine",
        "36": "Indre",
        "37": "Indre-et-Loire",
        "38": "Isère",
        "39": "Jura",
        "40": "Landes",
        "41": "Loir-et-Cher",
        "42": "Loire",
        "43": "Haute-Loire",
        "44": "Loire-Atlantique",
        "45": "Loiret",
        "46": "Lot",
        "47": "Lot-et-Garonne",
        "48": "Lozère",
        "49": "Maine-et-Loire",
        "50": "Manche",
        "51": "Marne",
        "52": "Haute-Marne",
        "53": "Mayenne",
        "54": "Meurthe-et-Moselle",
        "55": "Meuse",
        "56": "Morbihan",
        "57": "Moselle",
        "58": "Nièvre",
        "59": "Nord",
        "60": "Oise",
        "61": "Orne",
        "62": "Pas-de-Calais",
        "63": "Puy-de-Dôme",
        "64": "Pyrénées-Atlantiques",
        "65": "Hautes-Pyrénées",
        "66": "Pyrénées-Orientales",
        "67": "Bas-Rhin",
        "68": "Haut-Rhin",
        "69": "Rhône",
        "70": "Haute-Saône",
        "71": "Saône-et-Loire",
        "72": "Sarthe",
        "73": "Savoie",
        "74": "Haute-Savoie",
        "75": "Paris",
        "76": "Seine-Maritime",
        "77": "Seine-et-Marne",
        "78": "Yvelines",
        "79": "Deux-Sèvres",
        "80": "Somme",
        "81": "Tarn",
        "82": "Tarn-et-Garonne",
        "83": "Var",
        "84": "Vaucluse",
        "85": "Vendée",
        "86": "Vienne",
        "87": "Haute-Vienne",
        "88": "Vosges",
        "89": "Yonne",
        "90": "Territoire de Belfort",
        "91": "Essonne",
        "92": "Hauts-de-Seine",
        "93": "Seine-Saint-Denis",
        "94": "Val-de-Marne",
        "95": "Val-d'Oise",
        "971": "Guadeloupe",
        "972": "Martinique",
        "973": "Guyane",
        "974": "La Réunion",
        "976": "Mayotte"
    ]
}

#Preview {
    AFMapView()
}
