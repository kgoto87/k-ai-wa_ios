import SwiftUI

struct ClientListView: View {
    @StateObject private var viewModel = ClientViewModel()
    @State private var showingAddClientSheet = false
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                List {
                    ForEach(viewModel.clients.filter { searchText.isEmpty ? true : $0.name.contains(searchText) || $0.externalId.contains(searchText) }) { client in
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

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        if !text.isEmpty {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
        }
    }
}

struct ClientListView_Previews: PreviewProvider {
    static var previews: some View {
        ClientListView()
    }
}
