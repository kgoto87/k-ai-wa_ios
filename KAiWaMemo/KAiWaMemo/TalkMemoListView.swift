import SwiftUI

struct TalkMemoListView: View {
    @StateObject private var viewModel = TalkMemoViewModel()
    @State private var isAddingMemo = false
    var clientID: String

    var body: some View {
        NavigationView {
            List(viewModel.talkMemos) {
                memo in
                NavigationLink(destination: TalkMemoDetailView(memo: memo)) {
                    VStack(alignment: .leading) {
                        Text(memo.title).font(.headline)
                        Text(memo.date, style: .date).font(.caption)
                    }
                }
            }
            .navigationTitle("Talk Memos")
            .navigationBarItems(trailing: Button(action: {
                isAddingMemo.toggle()
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $isAddingMemo) {
                AddTalkMemoView(clientID: clientID)
            }
            .onAppear {
                viewModel.fetchTalkMemos(clientID: clientID)
            }
        }
    }
}

struct TalkMemoListView_Previews: PreviewProvider {
    static var previews: some View {
        TalkMemoListView(clientID: "123")
    }
}
