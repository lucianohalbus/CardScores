//Created by Halbus Development

import SwiftUI

struct TabbarView: View {
    
    @Binding var showLoginView: Bool
    @State var addNewMatchIsPresented: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                TabView {
                    Group {
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
                    .toolbarBackground(Color.cardColor.opacity(0.2), for: .tabBar)
                    .toolbarBackground(.visible, for: .tabBar)
                    .toolbarColorScheme(.light, for: .tabBar)
                }
                .tint(Color.cardColor)
                
                Button (action: {
                    self.addNewMatchIsPresented = true
                }) {
                    ZStack{
                        
                        Circle()
                            .stroke(Color.gray, lineWidth: 3)
                            .frame(width: 55, height: 55)
                            .shadow(radius: 100)
                        
                        Circle()
                            .stroke(Color.cardColor, lineWidth: 3)
                            .frame(width: 50, height: 50)
                            .shadow(radius: 100)
                        
                        Circle()
                            .frame(width: 30, height: 30)
                            .background(.black)
                            .foregroundColor(Color.cardColor)
                        
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .shadow(radius: 100)
                            .tint(Color.mainButtonColor)
                    }
                }
                .offset(y: proxy.size.height / 2.2)
            }
        }
    }
}

#Preview {
    TabbarView(showLoginView: .constant(false))
}
