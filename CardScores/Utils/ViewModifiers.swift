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
            .cornerRadius(10)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray)
            )
    }
}
