//Created by Halbus Development

import Foundation
import SwiftUI

final class MatchFBListViewModel: ObservableObject {
    private var repo: FirebaseRepository
    @Published var matchesFB: [MatchFB] = []
    
    init() {
        repo = FirebaseRepository()
        getMatches()
    }
    
    func getMatches() {
        repo.get { result in
            switch result {
            case .success(let fetchedItems):
                if let fetchedItems = fetchedItems {
                    DispatchQueue.main.async {
                      self.matchesFB.append(contentsOf: fetchedItems)
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
