//
//  ContentView.swift
//  test-jp
//
//  Created by Jérémie on 26/08/2024.
//

import SwiftUI
import SwiftData
import SwiftUICore

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Query private var items: [Item] = []
    @Query private var elaboratedItems: [ElaboratedItem] = []
    
    @State private var showingSheet = false
    @State private var userInput: String = ""
    @State private var errorText: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Items")) {
                    ForEach(items) { item in
                        NavigationLink {
                            Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                        } label: {
                            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                        }
                        .swipeActions(allowsFullSwipe: false) {
                            Button {
                                modelContext.delete(item)
                            } label: {
                                Text("Oui")
                            }
                            .tint(.red)
                        }
                    }
                }
                
                Section(header: Text("Elaborated Items")) {
                    ForEach(elaboratedItems) { elaboratedItem in
                        NavigationLink {
                            Text("Item at \(elaboratedItem.label)")
                        } label: {
                            Text("\(elaboratedItem.label)")
                        }
                        .swipeActions(allowsFullSwipe: false) {
                            Button {
                                modelContext.delete(elaboratedItem)
                            } label: {
                                Text("Oui")
                            }
                            .tint(.red)
                        }
                    }
                }
            }
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: deleteAllItems) {
                        Label("Delete All Items", systemImage: "trash.circle")
                    }
                    .tint(.orange)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                    .tint(.orange)
                }
                ToolbarItem() {
                    Button(action: addElaboratedItemSheet) {
                        Label("Add Item", systemImage: "plus.square")
                    }
                    .tint(.orange)
                }
            }
        }
        .sheet(isPresented: $showingSheet) {
            SheetView(showingSheet: $showingSheet, userInput: $userInput, errorText: $errorText)
        }
    }
    
    private func deleteAllItems() {
        withAnimation {
            try? modelContext.delete(model: Item.self)
            try? modelContext.delete(model: ElaboratedItem.self)
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }
    
    private func addElaboratedItem(label: String) {
        withAnimation {
            let newItem = ElaboratedItem(label: label)
            modelContext.insert(newItem)
        }
    }
    
    private func addElaboratedItemSheet() {
        self.showingSheet = true
    }
}

struct SheetView: View {
    @Binding var showingSheet: Bool
    @Binding var userInput: String
    @Binding var errorText: String

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Entrer le texte")
                    TextField("", text: $userInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
                .padding(.horizontal)
                .padding(.top, 60)
                
                Text("\(errorText)")
                    .bold()
                    .foregroundColor(.red)
                    .padding()
                    .frame(height: 30)
                
                Button {
                    if userInput.isEmpty {
                        errorText = "Mets qqch dans le texte frérot"
                    } else {
                        errorText = ""
                        addElaboratedItem(label: userInput)
                        userInput = ""
                        dismiss()
                    }
                } label: {
                    Image(systemName: "plus.square")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                .buttonBorderShape(.roundedRectangle)
                .padding(.bottom, 60)
            }
            .navigationBarBackButtonHidden()
           // .navigationBarTitle("Ajouter un élément", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.square")
                    }
                    .tint(.orange)
                }
            }
        }
        .presentationDetents([.height(200)])
    }

    func addElaboratedItem(label: String) {
        // Ajoutez ici votre logique pour ajouter un élément élaboré
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
