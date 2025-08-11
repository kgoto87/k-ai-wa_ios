import Foundation
import FirebaseFirestore

class ContentViewModel: ObservableObject {
    @Published var message = ""
    @Published var showAlert = false
    @Published var errorMessage = ""

    func writeToFirestore() {
        let db = Firestore.firestore()
        db.collection("test").addDocument(data: ["message": "Hello, Firebase!"]) { error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = "Error writing document: \(error.localizedDescription)"
                    self.showAlert = true
                } else {
                    self.message = "Document successfully written!"
                }
            }
        }
    }
}
