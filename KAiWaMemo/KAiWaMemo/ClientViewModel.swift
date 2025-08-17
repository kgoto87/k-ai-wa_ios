import Foundation
import FirebaseFirestore
import Combine
import FirebaseAuth

class ClientViewModel: ObservableObject {
    @Published var clients = [Client]()
    var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?

    func fetchClients(for userId: String? = nil) {
        let effectiveUserId: String?
        if let userId = userId {
            effectiveUserId = userId
        } else {
            effectiveUserId = Auth.auth().currentUser?.uid
        }

        guard let finalUserId = effectiveUserId else {
            print("User not logged in or user ID not provided")
            return
        }

        if listenerRegistration != nil {
            listenerRegistration?.remove()
        }

        listenerRegistration = db.collection("clients")
            .whereField("userId", isEqualTo: finalUserId)
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    print("Error getting clients: \(error.localizedDescription)")
                    return
                }

                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }

                self.clients = documents.compactMap { queryDocumentSnapshot -> Client? in
                    return try? queryDocumentSnapshot.data(as: Client.self)
                }
            }
    }

    func addClient(client: Client) {
        do {
            _ = try db.collection("clients").addDocument(from: client)
        } catch {
            print("Error adding client: \(error.localizedDescription)")
        }
    }

    func updateClient(client: Client) {
        if let documentId = client.id {
            do {
                try db.collection("clients").document(documentId).setData(from: client)
            } catch {
                print("Error updating client: \(error.localizedDescription)")
            }
        }
    }

    func deleteClient(at offsets: IndexSet) {
        let clientsToDelete = offsets.map { self.clients[$0] }
        for client in clientsToDelete {
            if let documentId = client.id {
                db.collection("clients").document(documentId).delete { error in
                    if let error = error {
                        print("Error removing client: \(error.localizedDescription)")
                    }
                }
            }
        }
    }

    deinit {
        listenerRegistration?.remove()
    }
}
