//
//  AFViewModel.swift
//  test-jp
//
//  Created by Jérémie on 13/09/2024.
//

import Foundation
import Alamofire
import SwiftData
import SwiftUICore

class ResultatsViewModel: ObservableObject {
   
    @Published var resultsDepartment: [ResultDepartment] = []
    @Published var resultsCirconscription: [ResultCirconscription] = []
    @Published var resultsDepute: [ResultDepute] = []

    @Published var isLoading: Bool = true
    
    func getDepartementResults(completion: @escaping () -> Void) {
        
        var url = "https://www.data.gouv.fr/fr/datasets/r/8d4a6927-c96f-4cf5-b757-ea745eca26bd"
        
        AF.download(url).responseURL { response in
            switch response.result {
                case .success(let fileURL):
                    print("Fichier téléchargé à : \(fileURL)")
                    do {
                        let content = try String(contentsOf: fileURL, encoding: .utf8)
                        let lines = content.components(separatedBy: .newlines)
                        var responseData: [ResultDepartment] = []
                        var firstLine = false
                        for line in lines {
                            if firstLine, !line.isEmpty {
                                responseData.append(ResultDepartment(from: line))
                            } else {
                                firstLine = true
                            }
                        }
                        self.resultsDepartment = responseData
                       
                    } catch {
                        print("Erreur lors de la lecture du fichier des départements: \(error)")
                    }
                    // Vous pouvez maintenant utiliser fileURL pour accéder au fichier
                case .failure(let error):
                    print("Erreur lors du téléchargement des départements : \(error)")
            }
        }
        
        url = "https://www.data.gouv.fr/fr/datasets/r/41ed46cd-77c2-4ecc-b8eb-374aa953ca39"
        
        AF.download(url).responseURL { response in
            switch response.result {
                case .success(let fileURL):
                    print("Fichier téléchargé à : \(fileURL)")
                    do {
                        let content = try String(contentsOf: fileURL, encoding: .utf8)
                        let lines = content.components(separatedBy: .newlines)
                        var responseData: [ResultCirconscription] = []
                        var firstLine = false
                        for line in lines {
                            if firstLine, !line.isEmpty {
                                responseData.append(ResultCirconscription(from: line))
                            } else {
                                firstLine = true
                            }
                        }
                        self.resultsCirconscription = responseData
                        self.isLoading = false
                        completion()
                    } catch {
                        print("Erreur lors de la lecture du fichier des circonscriptions : \(error)")
                    }
                case .failure(let error):
                    print("Erreur lors du téléchargement des circonscriptions : \(error)")
            }
        }
        
        url = "https://www.data.gouv.fr/fr/datasets/r/092bd7bb-1543-405b-b53c-932ebb49bb8e"
        
        AF.download(url).responseURL { response in
            switch response.result {
                case .success(let fileURL):
                    print("Fichier téléchargé à : \(fileURL)")
                    do {
                        let content = try String(contentsOf: fileURL, encoding: .utf8)
                        var lines = content.components(separatedBy: .newlines)
                        var responseData: [ResultDepute] = []
                        var firstLine = false
                        lines[364] += lines[364]
                        lines[365] = ""
                        print("Line 365 \(lines[365])")
                        print("Line 366 \(lines[366])")
                        print("Line 367 \(lines[367])")
                        for line in lines {
                            if firstLine, !line.isEmpty {
                                responseData.append(ResultDepute(from: line))
                            } else {
                                firstLine = true
                            }
                        }
                        self.resultsDepute = responseData
                        self.isLoading = false
                        completion()
                    } catch {
                        print("Erreur lors de la lecture du fichier des circonscriptions : \(error)")
                    }
                case .failure(let error):
                    print("Erreur lors du téléchargement des circonscriptions : \(error)")
            }
        }
    }
}
