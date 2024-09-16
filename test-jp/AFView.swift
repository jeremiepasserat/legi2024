//
//  AFView.swift
//  test-jp
//
//  Created by Jérémie on 27/08/2024.
//

import SwiftUI
import InteractiveMap
import SwiftData

struct AFView: View {
    
    @Environment(\.modelContext) private var modelContext
    @StateObject var viewModel = AFViewModel()
    @Query private var electionResultsByDepartement: [ElectionResultsByDepartement] = []
    
    var body: some View {
        VStack {
            
            List {
                ForEach(electionResultsByDepartement, id: \.codeDepartement){ result in
                    NavigationLink {
                        AFDetailView(dataObject: result)
                    } label: {
                        HStack{Text(result.codeDepartement) + Text (" ") + Text (result.libelleDepartement)}
                            .padding(.vertical)
                    }
                }
            }
        }
    }
}


#Preview {
    AFView()
}
