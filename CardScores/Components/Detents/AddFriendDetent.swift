//Created by Halbus Development

import Foundation
import SwiftUI

struct AddFriendDetent: CustomPresentationDetent {
    // 1
    static func height(in context: Context) -> CGFloat? {
        // 2
        return max(250, context.maxDetentValue * 0.1)
    }
}
