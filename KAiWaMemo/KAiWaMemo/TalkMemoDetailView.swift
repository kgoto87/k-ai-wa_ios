import SwiftUI

struct TalkMemoDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = TalkMemoViewModel()
    @State private var isEditingMemo = false
    var memo: TalkMemo

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(memo.title).font(.largeTitle)
            Text("Date: \(memo.date, style: .date)").font(.headline)
            Text("Topics: \(memo.topics.joined(separator: ", "))").font(.headline)
            Text("Summary:").font(.headline)
            Text(memo.summary)
            Text("Content:").font(.headline)
            Text(memo.content)
            Spacer()
        }
        .padding()
        .navigationTitle("Talk Memo Details")
        .navigationBarItems(trailing: HStack {
            Button(action: {
                isEditingMemo.toggle()
            }) {
                Image(systemName: "pencil")
            }
            Button(action: {
                viewModel.deleteTalkMemo(memo: memo)
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "trash")
            }
        })
        .sheet(isPresented: $isEditingMemo) {
            EditTalkMemoView(memo: memo)
        }
    }
}

struct TalkMemoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TalkMemoDetailView(memo: TalkMemo(id: "1", title: "Test Memo", content: "This is a test memo", date: Date(), topics: ["test", "swiftui"], summary: "This is a test summary", clientID: "123"))
    }
}
