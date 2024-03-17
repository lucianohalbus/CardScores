//Created by Halbus Development

import Foundation

final class AddNewBuracoFBViewModel: ObservableObject {
    @Published var playerOne: String = ""
    @Published var playerTwo: String = ""
    @Published var playerThree: String = ""
    @Published var playerFour: String = ""
    @Published var targetScore: String = ""
    @Published var repo: BuracoFirebaseRepository
    @Published var addNewSaved: Bool = false
    
    init() {
        repo = BuracoFirebaseRepository()
    }
    
    func add(match: MatchFB) {
        repo.add(match: match) { result in
            switch result {
            case .success(let fetcheredItem):
                print("New match was added")
            case .failure(let err):
               print(err)
            }
        }
    }
}
