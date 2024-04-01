//Created by Halbus Development

import SwiftUI

extension View {
    func errorAlert(error: Binding<Error?>, buttonTitle: String = "OK") -> some View {
        let localizedAlertError = MyError()
        return alert(isPresented: .constant(true), error: localizedAlertError) { _ in
            Button(buttonTitle) {
                error.wrappedValue = nil
            }
        } message: { error in
            Text(error.suggestion)
        }
    }
}

struct MyError: LocalizedError {
    let error: String = ""
    let suggestion: String = ""
}

