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
            case .success(let item):
                DispatchQueue.main.async {
                    self.addNewSaved = item == nil ? false : true
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
