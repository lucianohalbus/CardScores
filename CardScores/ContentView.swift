//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear(perform: {
            
            FirebaseRepository().login(email: "lpuzer@icloud.com", password: "assami05")
            print(Auth.auth().currentUser?.uid ?? "")
            print(Auth.auth().currentUser?.email ?? "")
            
            FirebaseRepository().get { result in
                switch result {
                case .success(let match):
                    print(match)
                case .failure(let err):
                    print(err)
                }
            }
        })
    }
}

#Preview {
    ContentView()
}
