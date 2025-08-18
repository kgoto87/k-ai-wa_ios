import SwiftUI

struct ClientDetailView: View {
    var client: Client
    @StateObject private var viewModel = ClientViewModel()

    var body: some View {
        VStack {
            Text(client.name).font(.largeTitle)
            Text(client.externalId).font(.title)
            Spacer()
            NavigationLink(destination: TalkMemoListView(clientID: client.id ?? "")) {
                Text("View Talk Memos")
            }
        }
        .navigationTitle("Client Details")
        .navigationBarItems(trailing: NavigationLink(destination: EditClientView(client: client, viewModel: viewModel)) {
            Text("Edit")
        })
    }
}

struct ClientDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ClientDetailView(client: Client(id: "1", name: "John Doe", externalId: "123", userId: "456"))
    }
}
