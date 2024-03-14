//Created by Halbus Development

import Foundation

enum CategoryEnum: String, CaseIterable {
    case all = ""
    case freezer = "Freezer"
    case fridge = "Fridge"
    case dryPantry = "Dry pantry"
    
    func desc() -> String {
        switch self {
        case .all:
            return "All"
        case .freezer:
            return "Freezer"
        case .fridge:
            return "Fridge"
        case .dryPantry:
            return "Dry pantry"
            
        }
    }
    
}
