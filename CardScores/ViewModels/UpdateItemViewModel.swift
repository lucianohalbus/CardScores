//Created by Halbus Development

import Foundation

//final class UpdateItemViewModel: ObservableObject {
//    private var repo: FirebaseRepository
//    
//    @Published var saved = false
//    @Published var categories: [Category] = []
//    
//    var id: String
//    var name: String
//    var quantity: String
//    var categoryName: String
//    var expirationDate: Date
//    
//    init(itemViewModel: MatchFBViewModel) {
//        repo = FirebaseRepository()
//        id = itemViewModel.id
//        name = itemViewModel.name
//        quantity = itemViewModel.quantity
//        categoryName = itemViewModel.categoryName
//        expirationDate = itemViewModel.expirationDate
//        
//        getCategories()
//    }
//    
//    func getCategories() {
//        repo.getPantryCategories { result in
//            switch result {
//            case .success(let fetchedCategories):
//                if let categories = fetchedCategories {
//                    DispatchQueue.main.async {
//                        self.categories = categories
//                    }
//                }
//                
//            case .failure(let err):
//                print(err.localizedDescription)
//            }
//        }
//    }
//    
//    func update() {
//        let item: Item = Item(id: id, name: name, quantity: quantity, categoryName: categoryName, expirationDate: expirationDate)
//        repo.update(item: item) { result in
//            switch result {
//            case .success(let success):
//                DispatchQueue.main.async {
//                    self.saved = success
//                }
//            case .failure(let err):
//                print(err.localizedDescription)
//            }
//        }
//    }
//}
