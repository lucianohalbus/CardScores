//Created by Halbus Development

import SwiftUI

//struct AddItemView: View {
//    @Environment(\.dismiss) private var dismiss
//    @StateObject private var addItemViewModel = AddItemViewModel()
//    
//    var body: some View {
//        NavigationView {
//            Form {
//                Section {
//                    TextField("Item name", text: $addItemViewModel.name)
//                    TextField("Quantity", text: $addItemViewModel.quantity)
//                    DatePicker("Expiration Date", selection: $addItemViewModel.expirationDate, in: Date()..., displayedComponents: [.date])
//                    
//                    Picker(selection: $addItemViewModel.categoryName) {
//                        ForEach(addItemViewModel.categories, id: \.id) {
//                            Text($0.name).tag($0.name)
//                        }
//                    } label: {
//                        Text("Category")
//                    }
//                    .pickerStyle(.segmented)
//                    
//                    HStack {
//                        Button("Save") {
//                            addItemViewModel.add()
//                        }
//                        .onChange(of: addItemViewModel.saved) {
//                            if  addItemViewModel.saved {
//                                dismiss()
//                            }
//                        }
//                        
//                        Spacer()
//                    }
//                }
//            }
//            .navigationTitle("Add new pantry item")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: { dismiss() }) {
//                        Image(systemName: "xmark")
//                    }
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    AddItemView()
//}
