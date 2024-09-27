//
//  AFView.swift
//  test-jp
//
//  Created by Jérémie on 27/08/2024.
//

import SwiftUI
import InteractiveMap
import SwiftData

struct DepartmentView: View {
    
//    @StateObject var viewModel = ResultatsViewModel()
    @Query(sort: \ResultDepartment.codeDepartement)
    private var electionResultsByDepartement: [ResultDepartment] = []
    
    var body: some View {
        VStack {
            
            List {
                ForEach(electionResultsByDepartement.sorted { $0.codeDepartement < $1.codeDepartement }, id: \.codeDepartement){ result in
                    NavigationLink {
                        DepartmentDetailView(dataObject: result)
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
    DepartmentView()
}
