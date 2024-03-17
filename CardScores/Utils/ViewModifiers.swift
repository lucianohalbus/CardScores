//Created by Halbus Development

import SwiftUI

struct LoginTextField: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.title)
            .padding(5)
            .frame(width: 350, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .foregroundColor(Color.primary)
            .accentColor(Color.accentColor)
            .cornerRadius(10)
            .disableAutocorrection(true)
            .autocapitalization(.none)
    }
}


struct FlagField: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .foregroundColor(Color("ForegroundTextField"))
            .accentColor(Color("ForegroundTextField"))
            .font(.title)
            .padding()
            .frame(width: 60, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color("BackgroundTextField"))
            .cornerRadius(10)
            .disableAutocorrection(true)
            .autocapitalization(.none)
    }
}


struct PlayerTexTField: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.title3)
            .foregroundColor(Color("ForegroundTextField"))
            .accentColor(Color("ForegroundTextField"))
            .frame(width: 150, height: 50, alignment: .center)
            .background(Color("BackgroundTextField"))
            .cornerRadius(10)
            .multilineTextAlignment(.center)
    }
}


struct PickerTexTField: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.title3)
            .frame(width: 150, height: 50, alignment: .center)
            .background(Color("BackgroundTextField"))
            .cornerRadius(10)
            .multilineTextAlignment(.center)
    }
}


struct TeamText: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.title2)
            .foregroundColor(Color("ForegroundTextField"))
            .frame(width: 140, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color("BackgroundTextField"))
            .cornerRadius(7)
            .multilineTextAlignment(.center)
    }
}


struct ScoreToWinTextField: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.largeTitle)
            .foregroundColor(Color("ForegroundTextField" ))
            .accentColor(Color("ForegroundTextField"))
            .frame(width: 310, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color("BackgroundTextField"))
            .cornerRadius(10)
            .multilineTextAlignment(.center)
    }
}


struct PositiveScoresText: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .frame(width: 120, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color("BackgroundTextField"))
            .cornerRadius(7)
            .multilineTextAlignment(.center)
            .foregroundColor(Color("ForeBlue"))
            .accentColor(Color("ForegroundTextField"))
    }
}


struct VulText: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .frame(width: 120, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color("BackgroundTextField"))
            .cornerRadius(7)
            .multilineTextAlignment(.center)
            .foregroundColor(Color("ForegroundTextField"))
    }
}


struct MatchTurnTexts: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.caption)
    }
}
