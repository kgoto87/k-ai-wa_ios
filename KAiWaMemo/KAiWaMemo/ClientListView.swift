import SwiftUI

struct ClientListView: View {
    @StateObject private var viewModel = ClientViewModel()
    @State private var showingAddClientSheet = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.clients) { client in
                    NavigationLink(destination: ClientDetailView(client: client)) {
                        VStack(alignment: .leading) {
                            Text(client.name)
                                .font(.headline)
                            Text("ID: \(client.externalId)")
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteClient)
            }
            .navigationTitle("Clients")
            .navigationBarItems(trailing: Button(action: {
                showingAddClientSheet = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddClientSheet) {
                AddClientView(viewModel: viewModel)
            }
                        .onAppear {
                viewModel.fetchClients()
            }
        }
    }
}

struct ClientListView_Previews: PreviewProvider {
    static var previews: some View {
        ClientListView()
    }
}
