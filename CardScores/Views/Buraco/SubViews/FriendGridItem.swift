//Created by Halbus Development

import SwiftUI

struct FriendGridItem: View {
    var friend: String
    @Binding var setSelectedButtonColor: Bool
    @Binding var cleanButtonColor: Color
    @State var backColor: Color = Color.white
    var actionAppend: () -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            Button {
                actionAppend()
                if setSelectedButtonColor {
                    backColor = Color.mainButtonColor
                }
            } label: {
                ZStack {
                    Text(friend)
                }
                
            }
            .modifier(FriendsButton(backColor: backColor))
        }
        .padding(.horizontal)
        .onChange(of: cleanButtonColor) { newValue in
            if newValue == Color.white {
                self.backColor = newValue
            }
        }
       
    }
}

#Preview {
    FriendGridItem(friend: "Friend", setSelectedButtonColor: .constant(false), cleanButtonColor: .constant(.white), actionAppend: {})
}
