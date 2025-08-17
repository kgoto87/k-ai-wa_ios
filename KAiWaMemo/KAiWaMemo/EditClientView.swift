import SwiftUI

struct EditClientView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var client: Client
    var viewModel: ClientViewModel

    var body: some View {
        Form {
            Section(header: Text("Client Details")) {
                TextField("Name", text: $client.name)
                TextField("External ID", text: $client.externalId)
            }
        }
        .navigationTitle("Edit Client")
        .navigationBarItems(trailing: Button("Save") {
            viewModel.updateClient(client: client)
            presentationMode.wrappedValue.dismiss()
        })
    }
}
