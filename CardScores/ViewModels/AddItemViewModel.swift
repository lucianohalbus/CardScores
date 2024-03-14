//Created by Halbus Development

import Foundation

//final class AddItemViewModel: ObservableObject {
//    private var repo: FirebaseRepository
//    @Published var categories: [Category] = []
//    @Published var saved: Bool = false
//    
//    var name: String = ""
//    var quantity: String = ""
//    var categoryName: String = "Freezer"
//    var expirationDate: Date = Date()
//    
//    init() {
//        repo = FirebaseRepository()
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
//    func add() {
//        let matchFB: MatchFB = MatchFB(scoreToWin: <#T##String#>, playerOne: <#T##String#>, playerTwo: <#T##String#>, playerThree: <#T##String#>, playerFour: <#T##String#>, myDate: <#T##Date#>, registeredUser: <#T##Bool#>, docId: <#T##String#>, gameOver: <#T##Bool#>)
//        let item: Item = Item(name: name, quantity: quantity, categoryName: categoryName, expirationDate: expirationDate)
//        
//        repo.add(item: item) { result in
//            switch result {
//            case .success(let item):
//                DispatchQueue.main.async {
//                    self.saved = item == nil ? false : true
//                }
//                
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//}
