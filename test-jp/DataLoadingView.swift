//
//  DataLoadingView.swift
//  test-jp
//
//  Created by Jérémie on 26/09/2024.
//

import SwiftUI

struct DataLoadingView: View {
    
    @StateObject private var viewModel = ResultatsViewModel()
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack() {
            if self.viewModel.isLoading {
                ProgressView("Chargement des données...")
                    .onAppear {
                        loadData()
                    }
            } else {
                HomeView()
            }
        }
    }
    
    private func loadData() {
        self.viewModel.getDepartementResults{
            try? modelContext.delete(model: ResultDepartment.self)
            for result in self.viewModel.resultsDepartment {
                modelContext.insert(result)
            }
            try? modelContext.delete(model: ResultCirconscription.self)
            for result in self.viewModel.resultsCirconscription {
                modelContext.insert(result)
            }
            try? modelContext.delete(model: ResultDepute.self)
            for result in self.viewModel.resultsDepute {
                modelContext.insert(result)
            }
//        try modelContext.save()
        }
    }
}

#Preview {
    DataLoadingView()
}
