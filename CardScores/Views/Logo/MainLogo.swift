//Created by Halbus Development

import SwiftUI

struct MainLogo: View {
    var body: some View {
        VStack {
            Text("Card Scores")
                .font(.title)
                .fontWeight(.semibold)
            
            ZStack{
                
                Circle()
                    .stroke(Color.black.gradient, lineWidth: 3)
                    .frame(width: 120, height: 120)
                
                Image("Logo")
                    .resizable()
                    .frame(width: 110, height: 110)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .shadow(color: .white, radius: 20, x: 0, y: 2)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200, alignment: .top)
        .padding(.bottom, 20)
        .hideKeyboardWhenTappedAround()
    }
}

struct MiniLogo: View {
    var body: some View {
        VStack {
            HStack {
                ZStack{
                    
                    Circle()
                        .stroke(Color.cardColor, lineWidth: 3)
                        .frame(width: 30, height: 30)
                    
                    Image("Logo")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .shadow(radius: 20)
                }
                
                Text("Card Scores")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
                
                ZStack{
                    
                    Circle()
                        .stroke(Color.cardColor, lineWidth: 3)
                        .frame(width: 30, height: 30)
                    
                    Image("Logo")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .shadow(radius: 20)
                }
            }
            
            Divider()
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .foregroundStyle(Color.white)
        }
        .padding(.bottom, 10)
    }
}

struct ToolBarLogo: View {
    var body: some View {
        HStack {
            ZStack{
                
                Circle()
                    .stroke(Color.cardColor, lineWidth: 3)
                    .frame(width: 30, height: 30)
                
                Image("Logo")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .shadow(radius: 25)
            }
        }
    }
}

#Preview {
    MainLogo()
}
