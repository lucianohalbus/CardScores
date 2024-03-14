//Created by Halbus Development

import SwiftUI

//struct UpdateItemView: View {
//    
//    @Environment(\.dismiss) private var dismiss
//    @StateObject private var updateItemViewModel: UpdateItemViewModel
//    
//    init(itemVM: ItemViewModel) {
//        _updateItemViewModel = StateObject<UpdateItemViewModel>.init(wrappedValue: UpdateItemViewModel(itemViewModel: itemVM))
//    }
//    
//    var body: some View {
//        Form {
//            Section {
//                TextField("Item name", text: $updateItemViewModel.name)
//                TextField("Quantity", text: $updateItemViewModel.quantity)
//                
//                DatePicker("Expiration Date", selection: $updateItemViewModel.expirationDate, in: Date()..., displayedComponents: [.date])
//                
//                Picker(selection: $updateItemViewModel.categoryName) {
//                    ForEach(updateItemViewModel.categories, id: \.id) {
//                        Text($0.name).tag($0.name)
//                    }
//                } label: {
//                    Text("Category")
//                }
//                .pickerStyle(.segmented)
//                
//                HStack {
//                    Spacer()
//                    
//                    Button("Upate Item") {
//                        updateItemViewModel.update()
//                    }
//                    .onChange(of: updateItemViewModel.saved) {
//                        if updateItemViewModel.saved {
//                            dismiss()
//                        }
//                    }
//
//                    Spacer()
//                }
//            }
//        }
//        .navigationTitle("Upadate Item")
//    }
//}
