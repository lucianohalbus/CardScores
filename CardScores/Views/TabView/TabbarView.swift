//Created by Halbus Development

import SwiftUI

struct TabbarView: View {
    
    @Binding var showLoginView: Bool
    @State var addNewMatchIsPresented: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                TabView {
                    NavigationStack {
                        BuracoListView(addNewMatchIsPresented: $addNewMatchIsPresented)
                    }
                    .tabItem {
                        Image(systemName: "lanyardcard.fill")
                        Text("Buraco")
                    }
                    
                    NavigationStack {
                        ProfileView(showLoginView: $showLoginView)
                    }
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
                }
                .tint(Color.cardColor)
                
                Button (action: {
                    self.addNewMatchIsPresented = true
                }) {
                    ZStack{
                        
                        Circle()
                            .stroke(Color.cardColor, lineWidth: 3)
                            .frame(width: 55, height: 55)
                        
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .shadow(radius: 100)
                            .tint(Color.cardColor)
                    }
                }
                .offset(y: proxy.size.height / 2.25)
            }
        }
    }
}

#Preview {
    TabbarView(showLoginView: .constant(false))
}
