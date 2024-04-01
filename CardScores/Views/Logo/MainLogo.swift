//Created by Halbus Development

import SwiftUI

struct MainLogo: View {
    var body: some View {

        Text("Card Scores")
            .font(.title)
            .fontWeight(.semibold)
        
        ZStack{
            
            Circle()
                .stroke(Color.cardColor, lineWidth: 3)
                .frame(width: 120, height: 120)
            
            Image("Logo")
                .resizable()
                .frame(width: 110, height: 110)
                .aspectRatio(contentMode: .fit)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .shadow(radius: 100)
        }
        .padding(5)
    }
}

struct MiniLogo: View {
    var body: some View {
        HStack {
            ZStack{
                
                Circle()
                    .stroke(Color.cardColor, lineWidth: 3)
                    .frame(width: 50, height: 50)
                
                Image("Logo")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .shadow(radius: 40)
            }
            .padding(5)
            
            
            Text("Card Scores")
                .font(.title)
                .fontWeight(.semibold)
            
            ZStack{
                
                Circle()
                    .stroke(Color.cardColor, lineWidth: 3)
                    .frame(width: 50, height: 50)
                
                Image("Logo")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .shadow(radius: 40)
            }
            .padding(5)
        }
    }
}

#Preview {
    MiniLogo()
}
