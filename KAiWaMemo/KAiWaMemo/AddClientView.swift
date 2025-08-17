import SwiftUI
import FirebaseAuth

struct AddClientView: View {
    @State private var name: String = ""
    @State private var externalId: String = ""
    @Environment(\.presentationMode) var presentationMode
    var viewModel: ClientViewModel

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Client Details")) {
                    TextField("Name", text: $name)
                    TextField("External ID", text: $externalId)
                }
            }
            .navigationTitle("Add New Client")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                guard let userId = Auth.auth().currentUser?.uid else { return }
                let newClient = Client(name: name, externalId: externalId, userId: userId)
                viewModel.addClient(client: newClient)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
