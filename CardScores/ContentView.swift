//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @ObservedObject var matcFBListhVM = MatchFBListViewModel()
    var body: some View {
        MatchesListView()
        
     //   .onAppear(perform: {
            
 //           FirebaseRepository().login(email: "lpuzer@icloud.com", password: "assami05")
//          print(Auth.auth().currentUser?.uid ?? "")
//          print(Auth.auth().currentUser?.email ?? "")
        
    //    })
    }
}

#Preview {
    ContentView()
}
