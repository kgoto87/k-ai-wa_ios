import SwiftUI

struct TalkMemoListView: View {
    @StateObject private var viewModel = TalkMemoViewModel()
    @State private var isAddingMemo = false
    @State private var searchText = ""
    var clientID: String

    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            List(viewModel.talkMemos.filter { searchText.isEmpty ? true : $0.title.contains(searchText) || $0.content.contains(searchText) || $0.summary.contains(searchText) || $0.topics.contains(where: { $0.contains(searchText) }) }) {
                memo in
                NavigationLink(destination: TalkMemoDetailView(memo: memo)) {
                    VStack(alignment: .leading) {
                        Text(memo.title).font(.headline)
                        Text(memo.date, style: .date).font(.caption)
                    }
                }
            }
        }
        .navigationTitle("Talk Memos")
        .navigationBarItems(trailing: 
            Button(action: {
                isAddingMemo.toggle()
            }) {
                Image(systemName: "plus")
            }
            .accessibility(identifier: "addMemoButton")
        )
        .sheet(isPresented: $isAddingMemo) {
            AddTalkMemoView(clientID: clientID)
        }
        .onAppear {
            viewModel.fetchTalkMemos(clientID: clientID)
        }
    }
}

struct TalkMemoListView_Previews: PreviewProvider {
    static var previews: some View {
        TalkMemoListView(clientID: "123")
    }
}
