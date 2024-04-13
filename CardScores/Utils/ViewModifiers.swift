//Created by Halbus Development

import SwiftUI

struct LoginTextField: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.title)
            .padding(5)
            .frame(width: 350, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .foregroundColor(Color.cardColor)
            .background(Color.white)
            .cornerRadius(10)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.textFieldBorderColor)
            )
    }
}

struct StandardButton: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.title)
            .padding(5)
            .frame(width: 350, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .foregroundColor(Color.cardColor)
            .background(Color.white)
            .cornerRadius(5)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray)
            )
    }
}

struct FriendsButton: ViewModifier {
    var backColor: Color
    func body(content: Content) -> some View {
        return content
            .font(.headline)
            .padding(5)
            .frame(width: 100, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .foregroundColor(Color.cardColor)
            .background(backColor)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray)
            )
    }
}
